DUNE = opam exec -- dune

.PHONY: test-vscode-compat
test-vscode-compat: ## Run opt-in vscode-textmate compatibility suite
	npm ci --prefix test/vscode
	$(DUNE) exec ./test/test_vscode_compat.exe
