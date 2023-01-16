local function map_key(key, fn, opts)
	local options = opts or { silent = true }
	vim.keymap.set({ "n", "x" }, key, fn, options)
end

SafeRequire("neoscroll", function(neoscroll)
	neoscroll.setup({
		-- known issues: <C-u>, <C-d>, <C-b>, <C-f> mess up macros (issue). see: https://github.com/karb94/neoscroll.nvim/issues/9
		mappings = { "<C-y>", "<C-e>", "zt", "zz", "zb" },
	})

	map_key("<C-j>", function()
		-- neoscroll.scroll(vim.wo.scroll, true, 250)
		neoscroll.scroll(10, true, 250)
	end)

	map_key("<C-k>", function()
		neoscroll.scroll(-10, true, 250)
	end)
end)
