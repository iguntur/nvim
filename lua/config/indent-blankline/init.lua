local highlight = {
	"RainbowGreen",
	"RainbowBlue",
	"RainbowYellow",
	"RainbowOrange",
	"RainbowCyan",
	"RainbowViolet",
	"RainbowRed",
}

vim.g.rainbow_delimiters = {
	highlight = highlight,
}

return function()
	SafeRequire("ibl", function(ibl)
		local hooks = require("ibl.hooks")

		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#72f5b5" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#CE006B" })
		end)

		-- char = "│" -- '|', '¦', '┆', '┊', `¦`, `┆`, `│`, `⎸`, or `▏`
		ibl.setup({
			indent = {
				char = "▏",
				tab_char = "▏",
				highlight = highlight,
			},
			scope = {
				-- char = "▏",
				char = "█",
				highlight = highlight,
				enabled = true,
			},
			whitespace = {
				highlight = highlight,
				remove_blankline_trail = true,
			},
		})
	end)
end