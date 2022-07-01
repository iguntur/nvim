.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*? ## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'

cleanup: ## Cleanup packer config
	rm -rf ~/.local/share/nvim/site/pack/packer

prepare: cleanup ## Get and prepare packer plugin manager
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

install: ## Install plugin using "PackerSync"
	nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"


.PHONY: help cleanup prepare install
