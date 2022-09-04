local M = {}
local keymap = vim.api.nvim_set_keymap

local isDisable = false

local function setup_go(go)
	go.setup({
		-- icons = { breakpoint = "🧘", currentpos = "🏃" }, -- setup to `false` to disable icons setup
		icons = { breakpoint = "🚦", currentpos = "👻" }, -- setup to `false` to disable icons setup
	})
end

M.setup = function(use)
	if isDisable then
		return
	end

	use("ray-x/go.nvim")
	use("ray-x/guihua.lua") -- recommanded if need floating window support

	SafeRequire("go", setup_go)
end

return M
