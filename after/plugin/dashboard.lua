SafeRequire("alpha", function(alpha)
	-- local themes = require("alpha.themes.startify")
	local themes = require("alpha.themes.dashboard")

	-- alpha.setup(themes.opts)
	alpha.setup(themes.config)

	-- themes.section.mru_cwd.val = { { type = "padding", val = 0 } }
	-- themes.section.bottom_buttons.val = {
	-- 	themes.button("e", "new file", ":ene <bar> startinsert <CR>"),
	-- 	themes.button("v", "neovim config", ":e ~/.config/nvim/init.lua<CR>"),
	-- 	themes.button("q", "quit nvim", ":qa<CR>"),
	-- }

	-- keymap('n', '<C-n>', ':Alpha<CR>', { noremap = true, silent = true })
end)
