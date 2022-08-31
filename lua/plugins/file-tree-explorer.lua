local M = {}
local keymap = vim.api.nvim_set_keymap

local function nvim_tree_setup(nvimTree)
	nvimTree.setup({
		-- sort_by = "case_sensitive",
		view = {
			adaptive_size = true,
			hide_root_folder = true,
			-- mappings = {
			-- 	list = {
			-- 		{ key = "u", action = "dir_up" },
			-- 	},
			-- },
		},
		renderer = {
			-- add_trailing = false,
			-- group_empty = false,
			highlight_git = true,
			-- full_name = false,
			highlight_opened_files = "all", -- "none", "icon" "name" "all"
			-- root_folder_modifier = ":~",
			indent_markers = {
				enable = true,
			},
		},
		filters = {
			dotfiles = true,
			-- custom = {},
			-- exclude = {},
		},
		git = {
			-- enable = true,
			ignore = false,
			-- timeout = 400,
		},
	})

	keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) -- Ctrl+b
	keymap("n", "<C-Space>", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true }) -- Ctrl+space
	-- keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
end

M.setup = function(use)
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})

	SafeRequire("nvim-tree", nvim_tree_setup)
end

return M
