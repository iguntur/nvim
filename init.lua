pcall(require, "impatient")

require("global.function")
require("settings.general")
require("settings.keymaps")

-- initiate plugin
-- Autocommand that reloads neovim whenever you save the init.lua file
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost ./init.lua source <afile> | PackerCompile
	augroup end
]])

-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, "packer")
if not ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({
				border = "rounded",
			})
		end,
	},
})

-- Plugins
return packer.startup(function(use)
	use({ "lewis6991/impatient.nvim" })
	use({ "wbthomason/packer.nvim" }) -- Packer can manage itself
	use({ "nvim-lua/popup.nvim" }) -- An implementation of the Popup API from vim in Neovim
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used in lots of plugins

	--
	-- treesitter
	--
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"p00f/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"theHamsta/nvim-treesitter-pairs",
			"mfussenegger/nvim-ts-hint-textobject",
			"windwp/nvim-ts-autotag",
		},
	})

	--
	-- colorscheme
	--
	use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }) -- gruvbox
	use({ "EdenEast/nightfox.nvim" }) -- nightfox, nordfox, dayfox, dawnfox and duskfox
	use({ "folke/tokyonight.nvim" }) -- tokyonight
	use({ "shaunsingh/moonlight.nvim" }) -- moonlight
	use({ "Shatur/neovim-ayu" }) -- ayu-<dark,light,mirage>
	use({ "RRethy/nvim-base16" }) -- base-16-<color-name>
	use({ "catppuccin/nvim", as = "catppuccin" })

	--
	-- appereances
	--
	use({ "feline-nvim/feline.nvim" })
	use({ -- dashboard (welcome page)
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" }, -- icons
	})
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" }, -- icons
	})
	use({ "lukas-reineke/indent-blankline.nvim" })

	--
	-- general, commons, utilities
	--
	use({ "rcarriga/nvim-notify" })
	use({ "folke/twilight.nvim" }) -- limelight like
	use({ "folke/zen-mode.nvim" })
	use({ "machakann/vim-highlightedyank" }) -- Make the yanked region apparent!

	--
	-- editorconfig
	--
	use({
		"editorconfig/editorconfig-vim",
		config = function()
			vim.g.EditorConfig_exclude_patterns = {
				"fugitive://.*", "scp://.*"
			}
		end
	})

	--
	-- easily change word casing with motions
	--
	use({ "arthurxavierx/vim-caser" }) -- Change text format case (eg: PascalCase, camelCase, etc...)

	--
	-- text align
	--
	use({ "junegunn/vim-easy-align" }) -- Text align
	use({ "godlygeek/tabular" })

	--
	-- telescope
	--
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			-- { "cljoly/telescope-repo.nvim" },
			{ "kdheepak/lazygit.nvim" },
		},
	})

	--
	-- harpoon
	--
	use({ "ThePrimeagen/harpoon" })

	--
	-- commenting
	--
	-- use("tpope/vim-commentary")
	use({ "numToStr/Comment.nvim" })

	--
	-- auto-pairs
	--
	-- use 'tpope/vim-unimpaired' -- auto pair for (), [], {}
	-- use 'jiangmiao/auto-pairs' -- auto pair for (), [], {}, "", '', ``
	use({ "raimondi/delimitmate" }) -- provides insert mode auto-completion for quotes, parens, brackets, etc

	--
	-- vim surround
	--
	use({ "tpope/vim-surround" }) -- quoting or parenthesizing made simple

	--
	-- LSP
	--
	use({
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- the completion plugin
			{ 'hrsh7th/cmp-buffer' }, -- buffer completions
			{ 'hrsh7th/cmp-path' }, -- path completions
			{ 'saadparwaiz1/cmp_luasnip' }, -- snippet completions
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },

			-- LSP Saga
			{ 'kkharji/lspsaga.nvim' } -- nightly
		}
	})

	--
	-- null ls
	--
	use({ "jose-elias-alvarez/null-ls.nvim" })

	--
	-- completion and snippets
	--
	-- use("hrsh7th/cmp-cmdline") -- command line completions
	-- use("SirVer/ultisnips") -- python snippets

	--
	-- emmet
	--
	use({
		"mattn/emmet-vim",
		config = function()
			vim.g.user_emmet_leader_key = "<C-Z>"
		end
	})

	--
	-- better whitespaces
	--
	use({
		"ntpeters/vim-better-whitespace",
		config = function()
			vim.g.better_whitespace_enabled = 1
			vim.g.strip_whitespace_on_save = 1
		end
	})

	--
	-- move line
	--
	use({
		"matze/vim-move",
		config = function()
			vim.g.move_key_modifier_visualmode = "M"
			vim.g.move_key_modifier = "M" -- Default 'A' (Alt)
			-- vim.g.move_map_keys = 0

			-- vim.keymap.set("n", "<Esc><Left>", "<Plug>MoveCharLeft<Esc>")
			-- vim.keymap.set("n", "<Esc><Right>", "<Plug>MoveCharRight<Esc>")
			-- vim.keymap.set("v", "<C-M-h>", "<Plug>MoveCharLeft")
			-- vim.keymap.set("v", "<C-M-l>", "<Plug>MoveCharRight")
		end
	})


	--
	-- misc
	--
	use({ "nathom/filetype.nvim" })

	--
	-- ...
	--
end)
