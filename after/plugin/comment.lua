SafeRequire("Comment", function(comment)
	comment.setup()

	local options = { silent = true }

	-- Keymaps: (Ctrl-/) commenting
	vim.api.nvim_set_keymap("n", "<C-_>", "gcc<Esc>", options)
	vim.api.nvim_set_keymap("v", "<C-_>", "gc<Esc>gv", options)
	vim.api.nvim_set_keymap("i", "<C-_>", "<Esc>gcc<Esc>", options)
end)
