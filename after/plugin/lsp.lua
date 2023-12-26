--   פּ ﯟ   some other good icons
-- find more here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local lsp_servers = {
	"bashls",                       -- shell script - sh
	"cssls",                        -- CSS language server
	"cssmodules_ls",                -- CSS modules
	"diagnosticls",                 -- Diagnostic language server integrate with linters
	"docker_compose_language_service", -- docker compose
	"dockerls",                     -- docker
	"emmet_ls",                     -- emmet
	"eslint",                       -- javascript and typescript linter
	"golangci_lint_ls",             -- Combination of both lint server and client
	"gopls",                        -- golang
	"grammarly",                    -- grammarly-languageserver (keywords: markdown, text)
	"graphql",                      -- graphql
	"html",                         -- html
	"jsonls",                       -- json
	"lua_ls",                       -- lua
	"pylsp",                        -- python (options: "jedi_language_server")
	"rust_analyzer",                -- rust
	"svelte",                       -- svelte
	"tailwindcss",                  -- tailwind
	"taplo",                        -- toml
	"tsserver",                     -- javascript, typescript
	"vimls",                        -- vim
	"yamlls",                       -- yaml
	-- "clangd", -- c, c++
	-- "intelephense", -- php
	-- "marksman", -- markdown
	-- "ocamllsp", -- ocaml
	-- "perlnavigator", -- perl
	-- "rescriptls", -- rescript
	-- -- "denols", -- deno
}

local function lsp_on_attach(client, bufnr)
	local options = { buffer = bufnr, remap = false }
	local keymap = vim.keymap.set

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- bind('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', options)
	-- bind('n', 'Q', function() print('Hello') end, { buffer = bufnr, desc = 'Say hello' })
	-- more code  ...

	keymap("n", "<leader>fx", function()
		vim.lsp.buf.format({})
	end, options)
	keymap("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", options)

	-- Handle by Lspsaga
	keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", options)
	keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", options)
	keymap("x", "<leader>rca", ":<c-u>Lspsaga range_code_action<CR>", options)
	keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", options)
	keymap("n", "<space>jl", "<cmd>Lspsaga show_line_diagnostics<CR>", options)
	keymap("n", "<space>jj", "<cmd>Lspsaga diagnostic_jump_next<CR>", options)
	keymap("n", "<space>jk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", options)
	-- bind("n", "gs", "<cmd>Lspsaga signature_help<CR>", options)

	SafeRequire("lspsaga.action", function(saga_action)
		-- keymap("n", "<C-u>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1, "<c-u>")<CR>', {})
		-- keymap("n", "<C-d>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1, "<c-d>")<CR>', {})
		keymap("n", "<C-u>", function()
			saga_action.smart_scroll_with_saga(-1, "<c-u>")
		end, {})

		keymap("n", "<C-d>", function()
			saga_action.smart_scroll_with_saga(1, "<c-d>")
		end, {})
	end)

	-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end

local function setup_nvim_cmp(lsp)
	local cmp = require("cmp")
	local cmp_mappings = lsp.defaults.cmp_mappings({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	})

	local config = {
		-- preselect = 'none',
		-- completion = {
		-- 	completeopt = 'menu,menuone,noinsert,noselect'
		-- },

		--
		-- key mapping
		--
		mapping = cmp_mappings,
		--
		-- sources
		--
		sources = {
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "buffer",  keyword_length = 3 },
		},
		--
		-- formatting
		--
		formatting = {
			fields = { "abbr", "kind", "menu" },
			format = function(entry, item)
				-- Kind icons
				-- item.kind = string.format('%s %s', kind_icons[item.kind], item.kind) -- This concatonates the icons with the name of the item kind
				item.kind = string.format("%s", kind_icons[item.kind])

				local menu_icon = {
					nvim_lsp = "λ",
					nvim_lua = "Π",
					luasnip = "⋗",
					buffer = "Ω",
					path = "🖫",
				}

				item.menu = menu_icon[entry.source.name]

				return item
			end,
		},
	}

	cmp.setup(config)
	-- return config
end

local function lsp_vim_config()
	vim.opt.signcolumn = "yes" -- Reserve space for diagnostic icons

	-- denols
	vim.g.markdown_fenced_languages = {
		"ts=typescript",
	}

	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		update_in_insert = false,
		underline = true,
		severity_sort = false,
		float = true,
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	-- ...
end

local function lsp_configure_server(lsp)
	local util = require("lspconfig.util")

	--
	-- Lua
	--
	lsp.configure("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	--
	-- JSON schema
	--
	local default_schemas = {}
	local has_config_schema, jsonls_settings = pcall(require, "nlspsettings.jsonls")
	if has_config_schema then
		default_schemas = jsonls_settings.get_default_schemas()
	end

	local schemas = require("settings.json-schema")

	local function extend(a, b)
		for _, value in ipairs(b) do
			table.insert(a, value)
		end

		return a
	end

	local extended_schemas = extend(schemas, default_schemas)
	lsp.configure("jsonls", {
		settings = {
			json = {
				schemas = extended_schemas,
			},
		},
		setup = {
			commands = {
				Format = {
					function()
						vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
					end,
				},
			},
		},
	})

	--
	-- typescript
	--
	-- local util = require("lspconfig").util
	lsp.configure("tsserver", {
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
		end,
		-- root_dir = function(fname)
		-- 	return util.root_pattern("tsconfig.json")(fname)
		-- 		or util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
		-- end,
	})

	--
	-- go
	--
	lsp.configure("gopls", {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_dir = util.root_pattern("go.work", "go.mod", ".git"),
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				-- analyses = {
				-- 	unusedparams = true,
				-- },
			},
		},
	})
end

-- SafeRequire("lspsaga", function(lspsaga)
-- 	lspsaga.setup({  })
-- end)

SafeRequire("lsp-zero", function(lsp)
	lsp.preset("recommended")
	-- lsp.ensure_installed(lsp_servers)
	-- lsp.set_preferences({
	-- 	set_lsp_keymaps = false,
	-- })

	lsp.on_attach(function(client, bufnr)
		lsp.default_keymaps({
			buffer = bufnr,
			preserve_mappings = false,
		})

		lsp_on_attach(client, bufnr)
	end)

	lsp_configure_server(lsp)

	SafeRequire("mason", function(mason)
		mason.setup()

		SafeRequire("mason-lspconfig", function(mod)
			mod.setup({
				ensure_installed = lsp_servers,
				handlers = {
					lsp.default_setup,
				},
			})
		end)
	end)

	-- lsp.nvim_workspace()

	-- lsp.setup_nvim_cmp(setup_nvim_cmp(lsp))
	setup_nvim_cmp(lsp)

	-- lsp.setup()

	lsp_vim_config()
end)