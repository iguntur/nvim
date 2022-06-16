local M = {}
local keymap = vim.api.nvim_set_keymap

M.setup = function(use)
	use("akinsho/toggleterm.nvim")

	-- see: https://github.com/akinsho/toggleterm.nvim
	SafeRequire("toggleterm", function(term)
		term.setup()

		keymap("n", "<leader>`", ":ToggleTerm direction=float<CR>", { noremap = true, silent = true })
	end)
end

return M
