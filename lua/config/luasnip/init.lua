local function load_from_vs_code()
	-- load snippets from path/of/your/nvim/config/my-cool-snippets
	-- require("luasnip.loaders.from_vscode").lazy_load({
	-- 	paths = {
	-- 		vim.fn.expand("$HOME/Library/Application Support/Code/User/snippets"),
	-- 	},
	-- })
end

local function setup_keymap()
	local ls = require("luasnip")

	vim.keymap.set({ "i", "s" }, "<c-j>", function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		end
	end, { silent = true })

	vim.keymap.set({ "i", "s" }, "<c-k>", function()
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end, { silent = true })

	vim.keymap.set({ "i" }, "<c-l>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end)

	local current_file = vim.fn.stdpath("config") .. "/lua/config/luasnip/init.lua"
	vim.keymap.set("n", "<leader><leader>s", function()
		pcall(vim.cmd, "source " .. current_file)
	end)
end

return function()
	-- Set the snippets directory
	local snippets_dir = vim.fn.stdpath("config") .. "/snippets"

	-- load from snipmate
	require("luasnip.loaders.from_snipmate").lazy_load({
		paths = snippets_dir,
	})

	setup_keymap()
end
