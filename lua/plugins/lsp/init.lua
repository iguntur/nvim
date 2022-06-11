local M = {}

local servers = {
	"bashls", -- shell script - sh
	"clangd", -- c
	"cssls", -- CSS
	"dartls", -- dart
	"dockerls", -- deno
	"emmet_ls", -- emmet
	"eslint", -- javascript, typescript
	"gopls", -- golang
	"graphql", -- graphql
	"html", -- html
	"intelephense", -- php
	"jdtls", -- java
	"jsonls", -- json
	"kotlin_language_server", -- kotlin
	"lemminx", -- xml
	"pyright", -- python
	"rescriptls", -- rust
	"rust_analyzer", -- rust
	"sqls", -- SQL
	"sumneko_lua", -- lua
	"svelte", -- svelte
	"tailwindcss", -- tailwind
	"taplo", -- toml
	"tsserver", -- javascript, typescript
	"vimls", -- vim
	"vuels", -- vue
	"yamlls", -- yaml
	"zk", -- markdown
	-- "denols", -- deno
	-- "ocamllsp", -- ocaml
	-- "perlnavigator", -- perl
	-- "prisma_ls", -- prisma
}
-- "hls", -- haskell
-- 'cssmodules_ls', -- CSS

local lsp_handler = require('plugins.lsp.handler')

local lsp_opts = {
	on_attach = lsp_handler.on_attach,
	capabilities = lsp_handler.capabilities,
}

local function setup_lsp_installer()
	local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')

	if not status_ok then
		return
	end

	-- Register a handler that will be called for all installed servers.
	-- Alternatively, you may also register handlers on specific server instances instead (see example below).
	lsp_installer.on_server_ready(function(server)
		-- do something ...
		local opts = lsp_opts

		for _, lsp in ipairs(servers) do
			if server.name == lsp then
				local has_explicit_config, extend_opts = pcall(require, 'plugins.lsp.settings.' .. lsp)

				if has_explicit_config then
					opts = vim.tbl_deep_extend('force', extend_opts, opts)
				end
			end
		end

		-- This setup() function is exactly the same as lspconfig's setup function.
		-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		server:setup(opts)
	end)
end

-- local function setup_language_server()
-- 	local ok, lsp_config = pcall(require, 'lspconfig')

-- 	if not ok then
-- 		return
-- 	end

-- 	for _, lsp in ipairs(servers) do
-- 		local has_explicit_config, extend_opts = pcall(require, 'plugins.lsp.settings.' .. lsp)

-- 		local opts = lsp_opts

-- 		if has_explicit_config then
-- 			opts = vim.tbl_deep_extend('force', extend_opts, opts)
-- 		end

-- 		lsp_config[lsp].setup(opts)
-- 	end
-- end

M.setup = function(use)
	use('neovim/nvim-lspconfig') -- enable LSP
	use('williamboman/nvim-lsp-installer') -- simple to use language server installer
	use('tamago324/nlsp-settings.nvim') -- language server settings defined in json for
	use('tami5/lspsaga.nvim') -- nightly

	-- setup_language_server()
	setup_lsp_installer()

	require('plugins.lsp.handler').setup()
end

return M
