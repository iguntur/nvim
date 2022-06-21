local M = {}
local keymap = vim.api.nvim_set_keymap

M.setup = function(use)
	-- use("tpope/vim-commentary") -- Commenting
	use({ "numToStr/Comment.nvim" })

	SafeRequire("Comment", function(comment)
		comment.setup()

		-- Keymaps: (Ctrl-/) commenting
		keymap("n", "<C-_>", "gcc<Esc>", { silent = true })
		keymap("v", "<C-_>", "gc<Esc>gv", { silent = true })
		keymap("i", "<C-_>", "<Esc>gcc<Esc>", { silent = true })
	end)
end

return M
