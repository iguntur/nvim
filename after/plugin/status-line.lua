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
	-- local options = {}
	local ok, ctp_feline = pcall(require, "catppuccin.groups.integrations.feline")

	if not ok then
		vim.notify("catppuccin feline integrations not found")
		return
	end

	local C = require("catppuccin.palettes").get_palette()
	local sett = {
		text = C.surface0,
		bkg = C.surface0,
		diffs = C.mauve,
		extras = C.overlay1,
		curr_file = C.maroon,
		curr_dir = C.flamingo,
	}

	local show_modified = false

	ctp_feline.setup({
		assets = assets,
	})

	local components = ctp_feline.get()
	local prevLeft = components.active[1]
	local prevRight = components.active[3]

	local filebar = prevRight[3]
	local currentDir = prevRight[4]

	currentDir.left_sep = {
		str = assets.left_separator,
		hl = {
			fg = sett.curr_dir,
			bg = sett.bkg,
		},
	}

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

	local left = {}
	left[1] = prevLeft[1]
	left[2] = prevLeft[2]
	left[3] = currentDir
	left[4] = filebar

	local center = components.active[2]

	local right = {}
	-- diff ---->
	right[1] = prevLeft[5]
	right[2] = prevLeft[6]
	right[3] = prevLeft[7]
	right[4] = prevLeft[8]
	right[5] = prevLeft[9]
	-- diff ---->

	right[6] = prevLeft[10]
	right[7] = prevLeft[11]
	right[8] = prevLeft[12]
	right[9] = prevLeft[13]

	right[10] = prevRight[1]
	right[11] = prevRight[2]

	components.active[1] = left
	components.active[2] = center
	components.active[3] = right

	feline.setup({
		components = components,
	})

	-- feline.winbar.setup()
	vim.o.wbr = vim.o.stl -- move statusline on top
end

SafeRequire("feline", feline_setup)
