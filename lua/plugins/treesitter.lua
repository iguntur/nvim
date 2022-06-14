local M = {}

local default_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local function kmap(mode, lhs, rhs, options)
	options = options or default_opts
	keymap(mode, lhs, rhs, options)
end

local function setup_treesitter()
	SafeRequire("nvim-treesitter.configs", function(config)
		config.setup({
			ensure_installed = "all", -- A list of parser names, or "all"
			sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
			ignore_install = { "" }, -- List of parsers to ignore installing
			highlight = {
				enable = true, -- false will disable the whole extension
				disable = { "" }, -- list of language that will be disabled

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
				disable = { "yaml" },
			},
			rainbow = {
				enable = true,
				-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
				extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
				-- colors = {}, -- table of hex strings
				-- termcolors = {} -- table of colour name strings
			},
			context_commentstring = {
				enable = true,
			},
			refactor = {
				-- highlight_definitions = { enable = true },
				-- highlight_current_scope = { enable = true },
				highlight_definitions = {
					enable = true,
					-- Set to false if you have an `updatetime` of ~100.
					-- clear_on_cursor_move = true,
				},
				navigation = {
					enable = true,
					keymaps = {
						goto_definition = "gnd",
						list_definitions = "gnD",
						list_definitions_toc = "gO",
						goto_next_usage = "<a-*>",
						goto_previous_usage = "<a-#>",
					},
				},
				smart_rename = {
					enable = true,
					keymaps = {
						smart_rename = "grr",
					},
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
			},
		})
	end)
end

local function setup_keymap()
	kmap("o", "m", ":<C-U>lua require('tsht').nodes()<CR>")
	kmap("v", "m", ":lua require('tsht').nodes()<CR>")
end

M.setup = function(use)
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"p00f/nvim-ts-rainbow",
			"nvim-treesitter/nvim-treesitter-refactor",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	})
	use("mfussenegger/nvim-ts-hint-textobject")

	setup_treesitter()
	setup_keymap()
end

return M
