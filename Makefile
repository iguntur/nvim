.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*? ## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'

backup: ## Backup nvim ~/.local (share, state)
	cp -r ~/.local/share/nvim ~/.local/share/nvim.bak
	cp -r ~/.local/state/nvim ~/.local/state/nvim.bak

restore: ## Restore nvim ~/.local (share, state)
	cp -r ~/.local/share/nvim.bak ~/.local/share/nvim
	cp -r ~/.local/state/nvim.bak ~/.local/state/nvim

cleanup: backup ## Cleanup packer config
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim

install: cleanup ## Get and prepare lazy plugin manager
	git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim

.PHONY: help backup restore cleanup install
