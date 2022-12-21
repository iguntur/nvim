local function harpoon_keymap_setup()
	vim.keymap.set("n", "zm", function()
		require("harpoon.mark").add_file()
	end)

	vim.keymap.set("n", "zs", function()
		require("harpoon.ui").toggle_quick_menu()
	end)

	vim.keymap.set("n", "zj", function()
		require("harpoon.ui").nav_next()
	end)

	vim.keymap.set("n", "zk", function()
		require("harpoon.ui").nav_prev()
	end)
end

SafeRequire("harpoon", function()
	harpoon_keymap_setup()
end)
