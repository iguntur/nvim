-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	group = vim.api.nvim_create_augroup("GT_GoFiletype", { clear = true }),
-- 	pattern = "*.go",
-- 	callback = function()
-- 		vim.lsp.buf.format()
-- 		vim.cmd([[ write ]])
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	group = vim.api.nvim_create_augroup("GT_GoFormat", { clear = true }),
-- 	pattern = "*.go",
-- 	callback = function()
-- 		-- local full_filepath = vim.fn.expand("%:f") -- t | f
-- 		-- D({ full_filepath })
-- 		-- vim.cmd([[ gofmt -l -s -w % ]])
-- 		-- vim.cmd([[ write ]])
-- 	end,
-- })

local format_group = vim.api.nvim_create_augroup("GoImport", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = format_group,
	pattern = "*.go",
	callback = function()
		SafeRequire("go.format", function(go)
			-- go.fmt() -- gofmt only
			go.goimport() -- goimport + gofmt
		end)
	end,
})
