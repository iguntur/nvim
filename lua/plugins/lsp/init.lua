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

local lsp_handler = require("plugins.lsp.handler")

local lsp_opts = {
	on_attach = lsp_handler.on_attach,
	capabilities = lsp_handler.capabilities,
}

local function setup_lsp_installer()
	SafeRequire("nvim-lsp-installer", function(lsp_installer)
		-- lsp_installer.setup({
		-- 	ensured_installed = servers
		-- })

		-- Register a handler that will be called for all installed servers.
		-- Alternatively, you may also register handlers on specific server instances instead (see example below).
		lsp_installer.on_server_ready(function(server)
			-- do something ...
			local opts = lsp_opts

			for _, lsp in ipairs(servers) do
				if server.name == lsp then
					-- vim.notify(server.name)
					SafeRequire("plugins.lsp.settings." .. lsp, function(extend_opts)
						opts = vim.tbl_deep_extend("force", extend_opts, opts)
					end)

					-- local has_explicit_config, extend_opts = pcall(require, "plugins.lsp.settings." .. lsp)

					-- if has_explicit_config then
					-- 	opts = vim.tbl_deep_extend("force", extend_opts, opts)
					-- end
				end
			end

			-- This setup() function is exactly the same as lspconfig's setup function.
			-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			server:setup(opts)
		end)
	end)
end

local function setup_lsp_config()
	SafeRequire("lspconfig", function(lspconfig)
		for _, lsp in ipairs(servers) do
			local opts = lsp_opts

			SafeRequire("plugins.lsp.settings." .. lsp, function(extend_opts)
				opts = vim.tbl_deep_extend("force", extend_opts, opts)
			end)

			-- local has_explicit_config, extend_opts = pcall(require, 'plugins.lsp.settings.' .. lsp)

			-- if has_explicit_config then
			-- 	opts = vim.tbl_deep_extend('force', extend_opts, opts)
			-- end

			lspconfig[lsp].setup(opts)
		end
	end)
end

M.setup = function(use)
	use({ -- simple to use language server installer
		"williamboman/nvim-lsp-installer",
		-- config = function()
		-- 	setup_lsp_installer()
		-- 	SafeRequire("nvim-lsp-installer", function(lsp_installer)
		-- 		-- @deprecated
		-- 		-- lsp_installer.setup({
		-- 		-- 	ensured_installed = servers
		-- 		-- })
		-- 	end)
		-- end
	})

	use({
		"neovim/nvim-lspconfig",
		after = "nvim-lsp-installer",
		-- config = function()
		-- 	setup_lsp_config()

		-- 	-- SafeRequire("lspconfig", function(lspconfig)
		-- 	-- 	lspconfig.sumneko_lua.setup()
		-- 	-- end)
		-- end
	})

	-- enable LSP
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("tami5/lspsaga.nvim") -- nightly

	setup_lsp_installer()
	setup_lsp_config()

	require("plugins.lsp.handler").setup()
end

return M
