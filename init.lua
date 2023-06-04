local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

pcall(require, "impatient")

require("global.function")
require("settings.general")
require("settings.keymaps")

-- Plugins
require("lazy").setup({
	{ "lewis6991/impatient.nvim" },
	{ "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used in lots of plugins

	--
	-- treesitter
	--
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-refactor" },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{ "p00f/nvim-ts-rainbow" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "theHamsta/nvim-treesitter-pairs" },
			{ "mfussenegger/nvim-treehopper" },
			{ "windwp/nvim-ts-autotag" },
		},
		config = require("config.treesitter"),
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = require("config.treesitter-context"),
	},

	{
		"nvim-treesitter/playground",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	--
	-- colorscheme
	--
	{
		"ellisonleao/gruvbox.nvim", -- gruvbox
		dependencies = {
			"rktjmp/lush.nvim",
		},
	},
	{ "EdenEast/nightfox.nvim" }, -- nightfox, nordfox, dayfox, dawnfox and duskfox
	{ "folke/tokyonight.nvim" }, -- tokyonight
	{ "shaunsingh/moonlight.nvim" }, -- moonlight
	{ "Shatur/neovim-ayu" }, -- ayu-<dark,light,mirage>
	{ "RRethy/nvim-base16" }, -- base-16-<color-name>
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	--
	-- appereances
	--
	{ "feline-nvim/feline.nvim" },
	{
		-- dashboard (welcome page)
		"goolord/alpha-nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" }, -- icons
	},
	-- TODO: try bufferline instead. see https://github.com/akinsho/bufferline.nvim
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	version = "v3.*",
	-- 	dependencies = "nvim-tree/nvim-web-devicons",
	-- },
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		}, -- icons
	},
	{ "lukas-reineke/indent-blankline.nvim" },
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	},

	--
	-- general, commons, utilities
	--
	{ "rcarriga/nvim-notify" },
	{ "folke/twilight.nvim" }, -- limelight like
	{ "folke/zen-mode.nvim" },
	{ "machakann/vim-highlightedyank" }, -- Make the yanked region apparent!
	{ "folke/neodev.nvim" },
	{
		"nvim-pack/nvim-spectre", -- search and replace text
		config = function()
			require("spectre").setup()
		end,
	},

	--
	-- jump and motions
	--
	-- { "unblevable/quick-scope" }, -- Quick jump with f/F
	-- { "ggandor/lightspeed.nvim" },
	{ "ggandor/leap.nvim" },
	{ "phaazon/hop.nvim" },

	--
	-- editorconfig
	--
	{
		"editorconfig/editorconfig-vim",
		config = function(plugin)
			vim.g.EditorConfig_exclude_patterns = {
				"fugitive://.*",
				"scp://.*",
			}
		end,
	},

	--
	-- Git Integration
	--
	{ "tpope/vim-fugitive" }, -- A Git wrapper so awesome
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "ThePrimeagen/git-worktree.nvim" },

	--
	-- easily change word casing with motions
	--
	{ "arthurxavierx/vim-caser" }, -- Change text format case (eg: PascalCase, camelCase, etc...)

	--
	-- text align
	--
	{ "junegunn/vim-easy-align" }, -- Text align
	{ "godlygeek/tabular" },

	--
	-- telescope
	--
	{
		"nvim-telescope/telescope.nvim",
		-- version = "0.1.0",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			-- { "cljoly/telescope-repo.nvim" },
			{ "kdheepak/lazygit.nvim" },
			{ "debugloop/telescope-undo.nvim" },
		},
	},

	--
	-- harpoon
	--
	{ "ThePrimeagen/harpoon" },

	--
	-- commenting
	--
	-- { "tpope/vim-commentary" },
	{ "numToStr/Comment.nvim" },

	--
	-- auto-pairs
	--
	-- use 'tpope/vim-unimpaired' -- auto pair for (), [], {}
	-- use 'jiangmiao/auto-pairs' -- auto pair for (), [], {}, "", '', ``
	{ "raimondi/delimitmate" }, -- provides insert mode auto-completion for quotes, parens, brackets, etc

	--
	-- vim surround
	--
	{ "tpope/vim-surround" }, -- quoting or parenthesizing made simple

	--
	-- LSP
	--
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- the completion plugin
			{ "hrsh7th/cmp-buffer" }, -- buffer completions
			{ "hrsh7th/cmp-path" }, -- path completions
			{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "tamago324/nlsp-settings.nvim" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			-- LSP Saga
			{ "kkharji/lspsaga.nvim" }, -- nightly
		},
	},

	--
	-- null ls
	--
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = require("config.null_ls"),
	},

	--
	-- completion and snippets
	--
	-- { "hrsh7th/cmp-cmdline" }, -- command line completions
	-- { "SirVer/ultisnips" }, -- python snippets

	--
	-- emmet
	--
	{
		"mattn/emmet-vim",
		config = function(plugin)
			vim.g.user_emmet_leader_key = "<C-Z>"
		end,
	},

	--
	-- better whitespaces
	--
	{
		"ntpeters/vim-better-whitespace",
		config = function(plugin)
			vim.g.better_whitespace_enabled = 1
			vim.g.strip_whitespace_on_save = 1
		end,
	},

	--
	-- move line
	--
	{
		"matze/vim-move",
		config = function(plugin)
			vim.g.move_key_modifier_visualmode = "M"
			vim.g.move_key_modifier = "M" -- Default 'A' (Alt)
			-- vim.g.move_map_keys = 0

			-- vim.keymap.set("n", "<Esc><Left>", "<Plug>MoveCharLeft<Esc>")
			-- vim.keymap.set("n", "<Esc><Right>", "<Plug>MoveCharRight<Esc>")
			-- vim.keymap.set("v", "<C-M-h>", "<Plug>MoveCharLeft")
			-- vim.keymap.set("v", "<C-M-l>", "<Plug>MoveCharRight")
		end,
	},

	--
	-- debugging and diagnostic
	--
	{
		"folke/trouble.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function(plugin)
			SafeRequire("trouble", function(trouble)
				trouble.setup()
			end)
		end,
	},

	--
	-- misc
	--
	{ "nathom/filetype.nvim" },
	{
		"folke/which-key.nvim",
		config = function(plugin)
			SafeRequire("which-key", function(which_key)
				which_key.setup()
			end)
		end,
	},
	{
		"AndrewRadev/splitjoin.vim",
		-- split and join keymaps:
		-- gS - to split a one-liner into multiple lines
		-- gJ - (with the cursor on the first line of a block) to join a block into a single-line statement.
	},

	--
	-- terminal
	--
	{
		"akinsho/toggleterm.nvim",
		config = function(plugin)
			-- see: https://github.com/akinsho/toggleterm.nvim
			SafeRequire("toggleterm", function(term)
				term.setup()

				-- leader + backtick (`)
				vim.keymap.set("n", "<leader>`", ":ToggleTerm direction=float<CR>")
			end)
		end,
	},

	--
	-- undo tree
	--
	{ "mbbill/undotree" },

	--
	-- misc
	-- TODO: make this work
	--
	-- {
	-- 	"RRethy/vim-illuminate",
	-- 	config = function(plugin)
	-- 		SafeRequire("illuminate", function(illuminate)
	-- 			illuminate.configure()
	--
	-- 			vim.keymap.set("n", "<M->>", illuminate.goto_next_reference, { desc = "Move to next reference" })
	-- 			vim.keymap.set("n", "<M-<>", illuminate.goto_prev_reference, { desc = "Move to previous reference" })
	-- 		end)
	-- 	end,
	-- },

	--
	-- todo comments
	--
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function(plugin)
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	--
	-- persistence session
	--
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function(plugin)
			require("persistence").setup()
		end,
	},

	--
	-- numb
	--
	{
		"nacro90/numb.nvim",
		config = function(plugin)
			require("numb").setup()
		end,
	},

	--
	-- neoscroll
	--
	{
		"karb94/neoscroll.nvim",
	},

	--
	-- dap
	--
	{ "mfussenegger/nvim-dap" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
	},

	{
		"ray-x/go.nvim",
		config = function(plugin)
			-- require("go").setup()
			require("go").setup({
				-- goimport = "goimports", -- goimport command, can be gopls[default] or goimport
				-- fillstruct = "gopls", -- can be nil (use fillstruct, slower) and gopls
				-- gofmt = "gofmt", -- gofmt cmd,
				tag_options = "", -- sets options sent to gomodifytags, i.e., json=omitempty
			})
		end,
	},

	--
	-- ...
	--
})
