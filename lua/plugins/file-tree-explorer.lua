local M = {}
local keymap = vim.api.nvim_set_keymap

M.setup = function(use)
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})

	SafeRequire("nvim-tree", function(nvimTree)
		nvimTree.setup({})

		keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) -- Ctrl+b
		keymap("n", "<C-Space>", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true }) -- Ctrl+space
		-- keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
	end)
end

return M
