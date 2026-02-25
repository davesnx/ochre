project_name = ochre

DUNE = opam exec -- dune
opam_file = $(project_name).opam

.PHONY: help
help: ## Print this help message
	@echo "";
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}';
	@echo "";

.PHONY: build
build: ## Build the project, including non installable libraries and executables
	$(DUNE) build --profile=dev

.PHONY: build-prod
build-prod: ## Build for production (--profile=prod)
	$(DUNE) build --profile=prod

.PHONY: dev
dev: ## Build in watch mode
	$(DUNE) build -w --profile=dev

.PHONY: clean
clean: ## Clean artifacts
	$(DUNE) clean

.PHONY: test
test: ## Run the unit tests
	$(DUNE) build @runtest

.PHONY: test-watch
test-watch: ## Run the unit tests in watch mode
	$(DUNE) build @runtest -w

.PHONY: test-promote
test-promote: ## Updates snapshots and promotes it to correct
	$(DUNE) build @runtest --auto-promote

.PHONY: format
format: ## Format the codebase with ocamlformat
	@DUNE_CONFIG__GLOBAL_LOCK=disabled $(DUNE) build @fmt --auto-promote

.PHONY: format-check
format-check: ## Checks if format is correct
	@DUNE_CONFIG__GLOBAL_LOCK=disabled $(DUNE) build @fmt

.PHONY: setup-githooks
setup-githooks: ## Setup githooks
	git config core.hooksPath .githooks

.PHONY: create-switch
create-switch: ## Create opam switch
	opam switch create . 5.4.0 --deps-only --with-test -y

.PHONY: install
install: ## Install opam dependencies
	CI=true opam install . --deps-only --with-test --with-doc --with-dev-setup -y

.PHONY: pin
pin: ## Pin dependencies
	opam pin dune https://github.com/ocaml/dune.git#main -y

.PHONY: init
init: setup-githooks create-switch pin install ## Create a local dev environment

.PHONY: subst
subst: ## Run dune substitute
	$(DUNE) subst

.PHONY: docs
docs: ## Generate markdown documentation from mli files
	$(DUNE) build @doc-markdown
	mkdir -p docs
	cp _build/default/_doc/_markdown/ochre/Ochre.md docs/ochre.md
	cp _build/default/_doc/_markdown/ochre/Ochre-Token.md docs/ochre-token.md
	cp _build/default/_doc/_markdown/ochre/Ochre-Theme.md docs/ochre-theme.md
	cp _build/default/_doc/_markdown/ochre-cli/cli.md docs/cli.md
