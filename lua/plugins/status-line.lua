local M = {}

local function lualine_setup(lualine)
	lualine.setup({
		options = {
			icons_enabled = true,
			theme = "catppuccin", -- 'auto'
			-- component_separators = { left = '?', right = '?'},
			-- section_separators = { left = '?', right = '?'},
			-- disabled_filetypes = {},
			-- always_divide_middle = true,
		},
		-- sections = {
		-- lualine_a = {'mode'},
		-- lualine_b = {'branch', 'diff', 'diagnostics'},
		-- lualine_c = {'filename'},
		-- lualine_x = {'encoding', 'fileformat', 'filetype'},
		-- lualine_y = {'progress'},
		-- lualine_z = {'location'}
		-- },
		-- inactive_sections = {
		-- lualine_a = {},
		-- lualine_b = {},
		-- lualine_c = {'filename'},
		-- lualine_x = {'location'},
		-- lualine_y = {},
		-- lualine_z = {}
		-- },
		-- tabline = {},
		-- extensions = {}
	})
end

local assets = {
	-- left_separator = "",
	-- right_separator = "",
	left_separator = " ",
	right_separator = " ",
	bar = "█",
	mode_icon = "",
	dir = "  ",
	file = "  ",
	lsp = {
		server = "  ",
		error = "  ",
		warning = "  ",
		info = "  ",
		hint = "  ",
	},
	git = {
		branch = "  ",
		added = "  ",
		changed = "  ",
		removed = "  ",
	},
}

local function feline_setup(feline)
	local options = {}
	local ok, ctp_feline = pcall(require, "catppuccin.groups.integrations.feline")

	if not ok then
		vim.notify("catppuccin feline integrations not found")
		return
	end

	local show_modified = false

	ctp_feline.setup({
		assets = assets,
	})

	local components = ctp_feline.get()
	local filebar = components.active[3][3]

	filebar.provider = function()
		local full_filepath = vim.fn.expand("%:f") -- t | f
		local project_filepath = vim.fn.fnamemodify(full_filepath, ":p:~:.")
		local extension = vim.fn.expand("%:e")
		local icon = require("nvim-web-devicons").get_icon(project_filepath, extension)

		if icon == nil then
			icon = assets.file
		end

		return (show_modified and "%m" or "") .. " " .. icon .. " " .. project_filepath .. " "
	end

	components.active[3][3] = filebar

	feline.setup({
		components = components,
	})

	-- feline.winbar.setup()
end

M.setup = function(use)
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
	})
	use({ "feline-nvim/feline.nvim" })

	-- SafeRequire("lualine", lualine_setup)
	SafeRequire("feline", feline_setup)

	vim.o.wbr = vim.o.stl -- move statusline on top
end

return M
