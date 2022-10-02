vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("GT_GoFiletype", { clear = true }),
	pattern = "*.go",
	callback = function()
		-- vim.lsp.buf.formatting_seq_sync()
		-- vim.lsp.buf.formatting_sync(nil, 500)
		vim.lsp.buf.format()
		-- vim.lsp.format()

		vim.cmd([[ write ]])
	end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = vim.api.nvim_create_augroup("GT_GoFormat", { clear = true }),
-- 	pattern = "*.go",
-- 	callback = function()
-- 		SafeRequire("go.format", function(formatter)
-- 			formatter.gofmt()
-- 		end)
-- 	end,
-- })
