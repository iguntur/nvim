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

local function feline_setup(feline)
	local options = {}
	local ok, components = pcall(require, "catppuccin.core.integrations.feline")

	if ok then
		options.components = components
	end

	feline.setup(options)
end

M.setup = function(use)
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
	})
	use({ "feline-nvim/feline.nvim",
		requires = {
			{ "catppuccin/nvim", as = "catppuccin" }
		}
	})

	-- SafeRequire("lualine", lualine_setup)
	SafeRequire("feline", feline_setup)
end

return M
