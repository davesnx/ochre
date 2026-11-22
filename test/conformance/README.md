# Conformance with vscode-textmate

This directory compares ochre's tokens with the tokens of `vscode-textmate`
9.x + `vscode-oniguruma`, the engine of VS Code and Shiki.

## What `dune runtest` checks

`test_conformance.ml` runs with `make test` and needs no Node. It tokenizes
`samples/<lang>.sample` with every bundled grammar of the opam `tm-grammars`
package, through the public `Ochre` API.

- Every grammar with a sample: no exception, the token texts join back to the
  sample, and the sample tokenizes in less than 0.25 s. The 0.25 s is the
  tokenizer's time limit for one line; ochre's API does not report a hit, so a
  sample that takes less than the limit in total proves that no line hit it.
  The first run compiles the grammar's regexes and is not timed; the check
  uses the fastest of the 3 runs after it.
- Every grammar on the `parity` list: each line's token texts and scope stacks
  equal `golden/<lang>.json`, which `vscode-textmate` wrote. A grammar in
  `expected_failures` must still differ; when it starts to match, the test
  fails until you remove it from the list.

`REPORT.md` gives the mismatch count for every bundled grammar.

## Samples

`samples/` holds the Shiki samples from
[shikijs/textmate-grammars-themes](https://github.com/shikijs/textmate-grammars-themes/tree/5bd656ce2db7d1c9de83d4fc81bc72a03d381949/samples)
at commit `5bd656ce`, the commit opam `tm-grammars` 2.0.0 takes its grammars
from (npm `tm-grammars` 1.31.8). `docker.sample` and `make.sample` are saved as
`dockerfile.sample` and `makefile.sample`, the opam language ids. Shiki has no
Reason sample, so `reason.sample` is written by hand.

The samples are under the MIT license of that repository, in
`samples/LICENSE`. Some samples carry their own copyright or license notice in
the file; those notices are kept as they are and apply to that file.

## Regenerate with Node

```sh
make conformance-golden   # rewrite golden/ for the parity list
make conformance-report   # rewrite REPORT.md
```

Both run `npm ci` here, write the bundled grammars and samples to
`_build/conformance/request.json`, and tokenize them with
`tokenize_vscode_textmate.mjs`. The script stops when a grammar of the opam
`tm-grammars` package differs from the same grammar in the npm `tm-grammars`
version in `package.json`. It does not check the grammars that opam takes from
vscode-ocaml-platform, and it prints the grammars that npm does not have. When you update opam `tm-grammars`, pin the npm
version built from the same commit and refresh `samples/` from that commit.

## Hand-written cases

`cases/suite.json` holds small cases for the vendored tokenizer. Run them from
the repository root with:

```sh
npm ci --prefix test/conformance
opam exec -- dune exec test/conformance/test_vscode_compat.exe
```
