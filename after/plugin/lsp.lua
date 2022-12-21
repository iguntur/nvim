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
	"bashls", -- shell script - sh
	"clangd", -- c, c++
	"cssls", -- CSS language server
	'cssmodules_ls', -- CSS modules
	"denols", -- deno
	"diagnosticls", -- Diagnostic language server integrate with linters
	"dockerls", -- docker
	"emmet_ls", -- emmet
	"eslint", -- javascript and typescript linter
	"golangci_lint_ls", -- Combination of both lint server and client
	"gopls", -- golang
	"graphql", -- graphql
	"html", -- html
	"intelephense", -- php
	"pyright", -- python (options: "jedi_language_server")
	"jsonls", -- json
	"marksman", -- markdown
	"ocamllsp", -- ocaml
	"perlnavigator", -- perl
	"pyright", -- python
	"rust_analyzer", -- rust
	"sumneko_lua", -- lua
	"svelte", -- svelte
	"tailwindcss", -- tailwind
	"taplo", -- toml
	"tsserver", -- javascript, typescript
	"vimls", -- vim
	"yamlls", -- yaml
}

local function on_attach(client, bufnr)
	local options = { buffer = bufnr, remap = false }
	local keymap = vim.keymap.set

	-- bind('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', options)
	-- bind('n', 'Q', function() print('Hello') end, { buffer = bufnr, desc = 'Say hello' })
	-- more code  ...

	keymap("n", "<leader>fx", "<cmd>lua vim.lsp.buf.formatting()<CR>", options)
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

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end

local function setup_nvim_cmp(lsp)
	local cmp = require('cmp')
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
			{ name = "buffer", keyword_length = 3 },
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
					nvim_lsp = 'λ',
					nvim_lua = 'Π',
					luasnip = '⋗',
					buffer = 'Ω',
					path = '🖫',
				}

				item.menu = menu_icon[entry.source.name]

				return item
			end,
		},
	}

	return config
end

local function lsp_vim_config()
	vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

	-- denols
	vim.g.markdown_fenced_languages = {
		"ts=typescript"
	}

	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		update_in_insert = false,
		underline = true,
		severity_sort = false,
		float = true,
	})

	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	-- 	border = "rounded",
	-- })

	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	-- 	border = "rounded",
	-- })

	-- ...
end

-- SafeRequire("lspsaga", function(lspsaga)
-- 	lspsaga.setup({  })
-- end)

SafeRequire("lsp-zero", function(lsp)
	lsp.preset('recommended')

	lsp.ensure_installed(lsp_servers)

	lsp.on_attach(on_attach)

	-- lsp.nvim_workspace()

	lsp.setup_nvim_cmp(
		setup_nvim_cmp(lsp)
	)

	lsp.setup()

	lsp_vim_config()
end)
