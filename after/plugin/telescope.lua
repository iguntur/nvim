local function telescope_setup(telescope)
	local action = require("telescope.actions")

	telescope.setup({
		defaults = {
			mappings = {
				n = {
					["<C-w>"] = action.close,
				},
				i = {
					["<C-w>"] = action.close,
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

local function load_extension(telescope)
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


local function setup_keymap()
	vim.keymap.set("n", "<C-g>", "<cmd>Telescope live_grep<CR>") -- search file by text/keyword inside of the file

	vim.keymap.set("n", "<Leader>fb", "<cmd>Telescope buffers<CR>") -- list the opened file buffers
	vim.keymap.set("n", "<Leader>f?", "<cmd>Telescope help_tags<CR>")

	-- Extensions
	-- Telescope file browser
	vim.keymap.set("n", "<Leader>fe", "<cmd>Telescope file_browser path=%:p:h<CR>")

	-- LSP
	--  go to definition
	-- vim.keymap.set("n", "<Leader>fd", "<cmd>Telescope lsp_definitions<CR>")
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>")

	--  go to implementation
	-- vim.keymap.set("n", "<Leader>fi", "<cmd>Telescope lsp_implementations<CR>")
	vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>")

	--  go to references
	-- vim.keymap.set("n", "<Leader>fr", "<cmd>Telescope lsp_references<CR>")
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>")

	vim.keymap.set("n", "<Leader>fws", "<cmd>Telescope lsp_workspace_symbols<CR>") -- go to workspace symbols
	vim.keymap.set("n", "<Leader>fds", "<cmd>Telescope lsp_document_symbols<CR>") -- go to document symbols

	vim.keymap.set("n", "<Leader>fcs", "<cmd>Telescope current_buffer_fuzzy_find<CR>") -- search text in the current buffer
	vim.keymap.set("n", "<M-g>", "<cmd>Telescope current_buffer_fuzzy_find<CR>") -- search text in the current buffer

	vim.keymap.set("n", "<Leader>fdl", "<cmd>Telescope diagnostics<CR>") -- show diagnostics list

	-- Commands
	vim.keymap.set("n", "<M-p>", "<cmd>Telescope commands<CR>")
	vim.keymap.set("n", "<Leader>fch", "<cmd>Telescope command_history<CR>")
	vim.keymap.set("n", "<Leader>km", "<cmd>Telescope keymaps<CR>")

	-- Extensions
	vim.keymap.set("n", "<Leader>gg", "<cmd>LazyGit<CR>")
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
	vim.keymap.set("n", "<Leader>vg", "<cmd>Telescope git_status<CR>")

	vim.keymap.set("n", "<C-p>", open_my_project_files) -- control-p: search file by filename
	vim.keymap.set("n", "<Leader>vd", open_mydotfiles)
	vim.keymap.set("n", "<Leader>vn", open_nvim_files)
	vim.keymap.set("n", "<Leader>vj", open_journals_files)
end

SafeRequire("telescope", function(telescope)
	telescope_setup(telescope)
	load_extension(telescope)

	setup_keymap()
	open_files_command()
end)