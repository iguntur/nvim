vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("GT_GoFiletype", { clear = true }),
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.formatting_seq_sync()
		vim.cmd([[ write ]])
	end,
})
