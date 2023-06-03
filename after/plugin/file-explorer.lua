local keymap = vim.keymap.set

local function nvim_tree_setup(nvimTree)
	nvimTree.setup({
		-- sort_by = "case_sensitive",
		view = {
			adaptive_size = true,
			-- hide_root_folder = true, -- deprecated (use: renderer.root_folder_label)
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
			root_folder_label = false,
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

	keymap("n", "<C-b>", ":NvimTreeToggle<CR>", {}) -- Ctrl+b
	keymap("n", "<C-Space>", ":NvimTreeFindFileToggle<CR>", {}) -- Ctrl+space
	-- keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', {})
end

SafeRequire("nvim-tree", nvim_tree_setup)
