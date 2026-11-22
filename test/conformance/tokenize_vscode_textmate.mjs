import { readFileSync } from "node:fs";
import { readFile } from "node:fs/promises";
import { createRequire } from "node:module";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { isDeepStrictEqual } from "node:util";
import { grammars as npmGrammars, injections as npmInjections } from "tm-grammars";
import oniguruma from "vscode-oniguruma";
import vsctm from "vscode-textmate";

const require = createRequire(import.meta.url);

function fail(message) {
  throw new Error(message);
}

function normalizeToken(token, line) {
  const start = Math.max(0, Math.min(token.startIndex, line.length));
  const end = Math.max(start, Math.min(token.endIndex, line.length));
  return {
    start,
    end,
    text: line.substring(start, end),
    scopes: token.scopes,
  };
}

async function loadOnigLib() {
  const wasmPath = require.resolve("vscode-oniguruma/release/onig.wasm");
  const wasm = readFileSync(wasmPath).buffer;
  await oniguruma.loadWASM(wasm);
  return {
    createOnigScanner(patterns) {
      return new oniguruma.OnigScanner(patterns);
    },
    createOnigString(text) {
      return new oniguruma.OnigString(text);
    },
  };
}

function parseRequest(rawJson) {
  const request = JSON.parse(rawJson);
  if (!request || !Array.isArray(request.cases)) {
    fail("Request must include a 'cases' array");
  }
  for (const item of request.cases) {
    if (typeof item.id !== "string") {
      fail("Case is missing string field 'id'");
    }
    if (typeof item.scope_name !== "string") {
      fail(`Case '${item.id}' is missing string field 'scope_name'`);
    }
    if (typeof item.grammar_path !== "string") {
      fail(`Case '${item.id}' is missing string field 'grammar_path'`);
    }
    if (!Array.isArray(item.lines) || item.lines.some((line) => typeof line !== "string")) {
      fail(`Case '${item.id}' is missing string-array field 'lines'`);
    }
  }
  for (const item of request.bundled_grammars ?? []) {
    if (
      typeof item.lang !== "string" ||
      typeof item.scope_name !== "string" ||
      typeof item.grammar_path !== "string"
    ) {
      fail("Each bundled grammar needs string fields 'lang', 'scope_name' and 'grammar_path'");
    }
  }
  return request;
}

// opam tm-grammars takes these grammars from ocamllabs/vscode-ocaml-platform,
// not from shikijs/textmate-grammars-themes (see its sources.json).
const notFromNpm = new Set(["cram", "dune", "menhir", "mlx", "ocaml", "ocamllex", "opam", "reason"]);

async function checkBundledGrammarsMatchNpm(bundled) {
  const npmRoot = dirname(fileURLToPath(import.meta.resolve("tm-grammars")));
  const npmVersion = JSON.parse(await readFile(join(npmRoot, "package.json"), "utf8")).version;
  const npmByScope = new Map([...npmGrammars, ...npmInjections].map((g) => [g.scopeName, g.name]));
  const differing = [];
  const notInNpm = [];
  for (const item of bundled) {
    const npmName = npmByScope.get(item.scope_name);
    if (notFromNpm.has(item.lang)) {
      continue;
    }
    if (!npmName) {
      notInNpm.push(item.lang);
      continue;
    }
    const opam = JSON.parse(await readFile(item.grammar_path, "utf8"));
    const npm = JSON.parse(await readFile(join(npmRoot, "grammars", `${npmName}.json`), "utf8"));
    if (!isDeepStrictEqual(opam, npm)) {
      differing.push(item.lang);
    }
  }
  if (notInNpm.length > 0) {
    process.stderr.write(
      `Version check skipped ${notInNpm.join(", ")}: npm tm-grammars ${npmVersion} has no grammar with that scope.\n`
    );
  }
  if (differing.length > 0) {
    fail(
      `npm tm-grammars ${npmVersion} is not the version opam tm-grammars was built from: ` +
        `${differing.join(", ")} differ. Pin the matching version in test/conformance/package.json ` +
        `and refresh test/conformance/samples/ from the same commit. If a listed grammar does not ` +
        `come from shikijs/textmate-grammars-themes, add it to notFromNpm.`
    );
  }
}

async function tokenizeAll(request) {
  const bundled = request.bundled_grammars ?? [];
  await checkBundledGrammarsMatchNpm(bundled);
  const scopeToGrammarPath = new Map();
  const injectionsByScope = new Map();
  for (const item of bundled) {
    scopeToGrammarPath.set(item.scope_name, item.grammar_path);
    const { injectTo } = JSON.parse(await readFile(item.grammar_path, "utf8"));
    for (const target of injectTo ?? []) {
      injectionsByScope.set(target, [...(injectionsByScope.get(target) ?? []), item.scope_name]);
    }
  }
  for (const item of request.cases) {
    const existing = scopeToGrammarPath.get(item.scope_name);
    if (existing && existing !== item.grammar_path) {
      fail(
        `Scope '${item.scope_name}' maps to multiple grammar files: '${existing}' and '${item.grammar_path}'`
      );
    }
    scopeToGrammarPath.set(item.scope_name, item.grammar_path);
  }

  const grammarCache = new Map();
  const registry = new vsctm.Registry({
    onigLib: loadOnigLib(),
    loadGrammar: async (scopeName) => {
      const grammarPath = scopeToGrammarPath.get(scopeName);
      if (!grammarPath) {
        return null;
      }
      const cached = grammarCache.get(grammarPath);
      if (cached) {
        return cached;
      }
      const raw = await readFile(grammarPath, "utf8");
      const grammar = vsctm.parseRawGrammar(raw, grammarPath);
      grammarCache.set(grammarPath, grammar);
      return grammar;
    },
    getInjections: (scopeName) => injectionsByScope.get(scopeName),
  });

  const cases = [];
  for (const item of request.cases) {
    const grammar = await registry.loadGrammar(item.scope_name);
    if (!grammar) {
      fail(`Could not load grammar for scope '${item.scope_name}'`);
    }
    let ruleStack = vsctm.INITIAL;
    const tokens_by_line = [];
    for (const line of item.lines) {
      const tokenized = grammar.tokenizeLine(line, ruleStack);
      tokens_by_line.push(
        tokenized.tokens.map((token) => normalizeToken(token, line))
      );
      ruleStack = tokenized.ruleStack;
    }
    cases.push({ id: item.id, tokens_by_line });
  }

  return { cases };
}

async function main() {
  const requestPath = process.argv[2];
  if (!requestPath) {
    fail("Usage: node tokenize_vscode_textmate.mjs <request.json>");
  }

  const requestRaw = await readFile(requestPath, "utf8");
  const request = parseRequest(requestRaw);
  const response = await tokenizeAll(request);
  process.stdout.write(`${JSON.stringify(response)}\n`);
}

main().catch((error) => {
  process.stderr.write(`${error && error.stack ? error.stack : String(error)}\n`);
  process.exit(1);
});
