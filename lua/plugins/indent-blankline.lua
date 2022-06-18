local M = {}

vim.cmd([[ highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine ]])
vim.cmd([[ highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine ]])
vim.cmd([[ highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine ]])
vim.cmd([[ highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine ]])
vim.cmd([[ highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine ]])
vim.cmd([[ highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine ]])

local function indent_blankline_setup(indent_blankline)
	indent_blankline.setup({
		space_char_blankline = " ",
		show_end_of_line = true,
		show_current_context = true,
		show_current_context_start = true,
		char_highlight_list = {
			"IndentBlanklineIndent1",
			"IndentBlanklineIndent2",
			"IndentBlanklineIndent3",
			"IndentBlanklineIndent4",
			"IndentBlanklineIndent5",
			"IndentBlanklineIndent6",
		},
	})
end

M.setup = function(use)
	use("lukas-reineke/indent-blankline.nvim")

	SafeRequire("indent_blankline", indent_blankline_setup)
end

return M
