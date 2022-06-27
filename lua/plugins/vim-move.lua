local M = {}

M.setup = function(use)
	use({ "matze/vim-move", tag = "v1.3" }) -- Move line

	-- Move line
	-- vim.g.move_key_modifier = 'C' -- Default 'A' (Alt)
end

return M
