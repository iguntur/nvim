local M = {}
local keymap = vim.api.nvim_set_keymap

local function setup_go(go)
	go.setup()
end

M.setup = function(use)
	use("ray-x/go.nvim")
	use("ray-x/guihua.lua") -- recommanded if need floating window support

	SafeRequire("go", setup_go)
end

return M
