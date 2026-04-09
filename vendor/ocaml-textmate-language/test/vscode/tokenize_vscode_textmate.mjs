import { readFileSync } from "node:fs";
import { readFile } from "node:fs/promises";
import { createRequire } from "node:module";
import oniguruma from "vscode-oniguruma";
import vsctm from "vscode-textmate";

const require = createRequire(import.meta.url);

function fail(message) {
  throw new Error(message);
}

function normalizeToken(token, lineLength) {
  const start = Math.max(0, Math.min(token.startIndex, lineLength));
  const end = Math.max(start, Math.min(token.endIndex, lineLength));
  return {
    start,
    end,
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
  return request;
}

async function tokenizeAll(request) {
  const scopeToGrammarPath = new Map();
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
        tokenized.tokens.map((token) => normalizeToken(token, line.length))
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
