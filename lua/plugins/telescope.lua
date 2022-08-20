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
	-- n_map("<C-p>", "<cmd>Telescope find_files<CR>") -- control-p: search file by filename
	-- v_map("<C-p>", "<cmd>Telescope find_files<CR>") -- control-p: search file by filename

	-- n_map("<Leader>pp", "<cmd>Telescope find_files<CR>") -- search file by filename
	-- n_map("<Leader>p", "<cmd>Telescope find_files no_ignore=true hidden=true<CR>") -- search file by filename
	n_map("<Leader>fg", "<cmd>Telescope live_grep<CR>") -- search file by text/keyword inside of the file
	n_map("<C-g>", "<cmd>Telescope live_grep<CR>") -- search file by text/keyword inside of the file

	n_map("<Leader>fb", "<cmd>Telescope buffers<CR>") -- list the opened file buffers
	n_map("<Leader>f?", "<cmd>Telescope help_tags<CR>")

	-- Extensions
	-- Telescope file browser
	n_map("<Leader>fe", "<cmd>Telescope file_browser path=%:p:h<CR>")

	-- LSP
	--  go to definition
	-- n_map("<Leader>fd", "<cmd>Telescope lsp_definitions<CR>")
	n_map("gd", "<cmd>Telescope lsp_definitions<CR>")

	--  go to implementation
	-- n_map("<Leader>fi", "<cmd>Telescope lsp_implementations<CR>")
	n_map("gi", "<cmd>Telescope lsp_implementations<CR>")

	--  go to references
	-- n_map("<Leader>fr", "<cmd>Telescope lsp_references<CR>")
	n_map("gr", "<cmd>Telescope lsp_references<CR>")

	n_map("<Leader>fws", "<cmd>Telescope lsp_workspace_symbols<CR>") -- go to workspace symbols
	n_map("<Leader>fds", "<cmd>Telescope lsp_document_symbols<CR>") -- go to document symbols

	n_map("<Leader>fcs", "<cmd>Telescope current_buffer_fuzzy_find<CR>") -- search text in the current buffer
	n_map("<M-g>", "<cmd>Telescope current_buffer_fuzzy_find<CR>") -- search text in the current buffer

	n_map("<Leader>fdl", "<cmd>Telescope diagnostics<CR>") -- show diagnostics list

	-- Commands
	n_map("<M-p>", "<cmd>Telescope commands<CR>")
	n_map("<Leader>fch", "<cmd>Telescope command_history<CR>")
	n_map("<Leader>km", "<cmd>Telescope keymaps<CR>")

	-- Extensions
	n_map("<Leader>gg", "<cmd>LazyGit<CR>")
end

local function open_my_project_files()
	local opts = {
		prompt_title = "~ FIND FILES ~",
		find_command = {
			"rg",
			"--files",
			"--no-ignore",
			"--hidden",
			"--ignore-file",
			vim.env.HOME .. "/.rgignore",
			"--sort",
			"path",
		},
	}

	require("telescope.builtin").find_files(opts)
end

local function open_mydotfiles()
	local opts = {
		prompt_title = "~ DOTFILES ~",
		cwd = vim.env.HOME .. "/.dotfiles",
		find_command = {
			"rg",
			"--files",
			"--no-ignore",
			"--hidden",
			"--ignore-file",
			vim.env.HOME .. "/.rgignore",
			"--sort",
			"path",
		},
	}

	require("telescope.builtin").find_files(opts)
end

local function open_nvim_files()
	local opts = {
		prompt_title = "~ NVIM ~",
		cwd = vim.env.HOME .. "/.config/nvim",
		find_command = {
			"rg",
			"--files",
			"--no-ignore",
			"--hidden",
			"--ignore-file",
			vim.env.HOME .. "/.rgignore",
			"--sort",
			"path",
		},
	}

	require("telescope.builtin").find_files(opts)
end

local function open_journals_files()
	local opts = {
		prompt_title = "~ JOURNALS ~",
		cwd = vim.env.HOME .. "/journals",
		find_command = {
			"rg",
			"--files",
			"--no-ignore",
			"--hidden",
			"--ignore-file",
			vim.env.HOME .. "/.rgignore",
			"--sort",
			"path",
		},
	}

	require("telescope.builtin").find_files(opts)
end

local function open_files_command()
	n_map("<Leader>vg", "<cmd>Telescope git_status<CR>")

	vim.keymap.set("n", "<C-p>", open_my_project_files) -- control-p: search file by filename
	vim.keymap.set("n", "<Leader>vd", open_mydotfiles)
	vim.keymap.set("n", "<Leader>vn", open_nvim_files)
	vim.keymap.set("n", "<Leader>vj", open_journals_files)
end

local function harpoon_keymap_setup()
	vim.keymap.set("n", "zm", function()
		require("harpoon.mark").add_file()
	end)
	vim.keymap.set("n", "zs", function()
		require("harpoon.ui").toggle_quick_menu()
	end)
	vim.keymap.set("n", "zj", function()
		require("harpoon.ui").nav_next()
	end)
	vim.keymap.set("n", "zk", function()
		require("harpoon.ui").nav_prev()
	end)
end

local function telescope_setup()
	local ok, telescope = pcall(require, "telescope")

	if not ok then
		return
	end

	local action = require("telescope.actions")

	telescope.setup({
		defaults = {
			-- mappings = {
			-- 	i = {
			-- 		["<Esc>"] = action.close,
			-- 	},
			-- },
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--no-ignore",
				"--hidden",
				"--ignore-file",
				vim.env.HOME .. "/.rgignore",
				"--sort",
				"path",
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
		-- 	-- file_browser = {
		-- 	-- 	-- path = vim.fn.expand("%:p:h"),
		-- 	-- },
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
		-- "repo", -- unedeed
		"lazygit",
		"harpoon",
	}

	for _, ext in ipairs(extensions) do
		_ = telescope.load_extension(ext)
	end
end

M.setup = function(use)
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			-- { "cljoly/telescope-repo.nvim" },
			{ "kdheepak/lazygit.nvim" },
		},
	})
	use("ThePrimeagen/harpoon")

	telescope_setup()
	load_extension()
	setup_keymap()
	open_files_command()
	harpoon_keymap_setup()
end

return M
