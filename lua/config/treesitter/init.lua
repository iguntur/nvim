vim.g.skip_ts_context_commentstring_module = true

-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set

local function setup_treesitter(ts)
	ts.setup({
		-- "theHamsta/nvim-treesitter-pairs"
		pairs = {
			enable = true,
		},
		-- "windwp/nvim-ts-autotag" Use treesitter to autoclose and autorename html tag
		autotag = {
			enable = true,
		},
		autopairs = {
			enable = true,
		},
		auto_install = false,
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"diff",
			"dockerfile",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"go",
			"gomod",
			"gosum",
			"graphql",
			"html",
			"ini",
			"javascript",
			"jsdoc",
			"json",
			"json5",
			"jsonc",
			"lua",
			"luadoc",
			"make",
			"markdown",
			"mermaid",
			"nix",
			"ocaml",
			"ocaml_interface",
			"php",
			"python",
			"rust",
			"sql",
			"toml",
			"tsx",
			"typescript",
			"yaml",
			-- "all", -- A list of parser names, or "all"
			-- "comment",
			-- "help",
			-- "http",
			-- "phpdoc",
			-- "scss",
			-- "solidity",
			-- "svelte",
			-- "vim",
			-- "vue",
			-- "zig",
		},
		sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
		ignore_install = {}, -- List of parsers to ignore installing
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
			disable = {
				-- "yaml",
			},
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
					goto_next_usage = "<M-)>",
					goto_previous_usage = "<M-(>",
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
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["<M-n>"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["<M-N>"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["<M-m>"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["<M-M>"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
	})
end

local function setup_keymap()
	-- "mfussenegger/nvim-treehopper"
	keymap("o", "m", ":<C-U>lua require('tsht').nodes()<CR>")
	keymap("x", "m", ":lua require('tsht').nodes()<CR>")
end

-- SafeRequire("nvim-treesitter.configs", setup_treesitter)
return function()
	local ts = require("nvim-treesitter.configs")

	setup_treesitter(ts)
	setup_keymap()

	SafeRequire("ts_context_commentstring", function(mod)
		mod.setup({
			enable_autocmd = false,
		})
	end)
end
