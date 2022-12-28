local function harpoon_keymap_setup()
	local mark = require("harpoon.mark")
	local ui = require("harpoon.ui")

	vim.keymap.set("n", "zm", function()
		mark.add_file()
	end)

	vim.keymap.set("n", "zs", function()
		ui.toggle_quick_menu()
	end)

	vim.keymap.set("n", "zj", function()
		ui.nav_next()
	end)

	vim.keymap.set("n", "zk", function()
		ui.nav_prev()
	end)
end

SafeRequire("harpoon", function()
	harpoon_keymap_setup()
end)
