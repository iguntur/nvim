local M = {}

-- local function keymap(mode, lhs, rhs)
-- 	vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
-- end

M.setup = function(use)
	use({ "matze/vim-move" }) -- Move line

	-- Move line
	vim.g.move_key_modifier_visualmode = "M"
	vim.g.move_key_modifier = "M" -- Default 'A' (Alt)
	-- vim.g.move_map_keys = 0

	-- keymap("n", "<Esc><Left>", "<Plug>MoveCharLeft<Esc>")
	-- keymap("n", "<Esc><Right>", "<Plug>MoveCharRight<Esc>")
	-- keymap("v", "<C-M-h>", "<Plug>MoveCharLeft")
	-- keymap("v", "<C-M-l>", "<Plug>MoveCharRight")
end

return M
