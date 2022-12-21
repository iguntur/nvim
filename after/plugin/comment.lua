SafeRequire("Comment", function(comment)
	comment.setup()

	-- Keymaps: (Ctrl-/) commenting
	vim.keymap.set("n", "<C-_>", "gcc<Esc>", { silent = true })
	vim.keymap.set("v", "<C-_>", "gc<Esc>gv", { silent = true })
	vim.keymap.set("i", "<C-_>", "<Esc>gcc<Esc>", { silent = true })
end)
