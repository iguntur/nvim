local M = {}

local function n_map(lhs, rhs)
	vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = true })
end

local function v_map(lhs, rhs)
	vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true, silent = true })
end

local function setup_keymap()
	-- Find files using Telescope command-line sugar.
	-- n_map('<Leader>ff', '<cmd>Telescope find_files<CR>') -- search file by filename
	n_map("<C-p>", "<cmd>Telescope find_files<CR>") -- control-p: search file by filename
	v_map("<C-p>", "<cmd>Telescope find_files<CR>") -- control-p: search file by filename

	-- n_map("<Leader>pp", "<cmd>Telescope find_files<CR>") -- search file by filename
	n_map("<Leader>p", "<cmd>Telescope find_files no_ignore=true hidden=true<CR>") -- search file by filename
	n_map("<Leader>fg", "<cmd>Telescope live_grep<CR>") -- search file by text/keyword inside of the file
	n_map("<Leader>fb", "<cmd>Telescope buffers<CR>") -- list the opened file buffers
	n_map("<Leader>f?", "<cmd>Telescope help_tags<CR>")

	-- Extensions
	-- Telescope file browser
	n_map("<Leader>fe", "<cmd>Telescope file_browser<CR>")

	-- LSP
	n_map("<Leader>fd", "<cmd>Telescope lsp_definitions<CR>")
	n_map("<Leader>fi", "<cmd>Telescope lsp_implementations<CR>")
	n_map("<Leader>fr", "<cmd>Telescope lsp_references<CR>")
	n_map("<Leader>fs", "<cmd>Telescope lsp_workspace_symbols<CR>")

	-- Commands
	n_map("<Leader>fch", "<cmd>Telescope command_history<CR>")
end

local function open_mydotfiles()
	local opts = {
		prompt_title = "~ DOTFILES ~",
		cwd = "$HOME/.dotfiles",
	}

	require("telescope.builtin").find_files(opts)
end

local function open_nvim_files()
	local opts = {
		prompt_title = "~ NVIM ~",
		cwd = "$HOME/.config/nvim",
	}

	require("telescope.builtin").find_files(opts)
end

local function open_files_command()
	-- search and open the file based on custom cwd
	vim.api.nvim_create_user_command("MyDotfiles", open_mydotfiles, {
		bang = true,
		desc = "search and open dotfiles config",
	})

	vim.api.nvim_create_user_command("MyNvim", open_nvim_files, {
		bang = true,
		desc = "search and open nvim config",
	})

	n_map("<Leader>vd", "<cmd>MyDotfiles<CR>")
	n_map("<Leader>vn", "<cmd>MyNvim<CR>")
end

local function telescope_setup()
	local ok, telescope = pcall(require, "telescope")

	if not ok then
		return
	end

	local action = require("telescope.actions")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<Esc>"] = action.close,
				},
			},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				-- "--no-ignore",
				-- "-u", -- alias for --unrestricted
				-- "--trim" -- add this value
			},
			layout_config = {
				prompt_position = "top",
			},
			sorting_strategy = "ascending",
		},
		-- pickers = {
		-- 	-- ...
		-- },
		-- extensions = {
		-- 	-- ...
		-- },
	})
end

local function load_extension()
	local ok, telescope = pcall(require, "telescope")

	if not ok then
		return
	end

	local extensions = {
		"fzf",
		"file_browser", -- load this after fzf
	}

	for _, ext in ipairs(extensions) do
		_ = telescope.load_extension(ext)
	end
end

M.setup = function(use)
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	telescope_setup()
	load_extension()
	setup_keymap()
	open_files_command()
end

return M
