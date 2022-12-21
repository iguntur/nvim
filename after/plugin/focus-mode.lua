SafeRequire("twilight", function(twilight)
	twilight.setup({
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	})

	vim.keymap.set("n", "<leader>l", ":Twilight<CR><Esc>")
	vim.keymap.set("x", "<leader>l", ":Twilight<CR><Esc>")
end)

SafeRequire("zen-mode", function(zen_mode)
	zen_mode.setup({
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	})

	vim.keymap.set("n", "<leader>zm", ":ZenMode<CR><Esc>")
end)
