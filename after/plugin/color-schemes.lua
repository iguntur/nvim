local function setup_keymap()
	vim.keymap.set("n", "<Leader>kt", "<cmd>Telescope colorscheme<CR>")
end

local function setup_colorscheme()
	-- local colorscheme = "gruvbox"
	local colorscheme = "catppuccin"
	-- local colorscheme = "base16-catppuccin"
	-- local colorscheme = "ayu-mirage"
	-- local colorscheme = "duskfox"
	local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

	if not ok then
		local default_colorscheme = "slate"
		vim.notify('colorscheme "' .. colorscheme .. '" not installed yet')
		vim.notify("set to default colorscheme " .. default_colorscheme)
		pcall(vim.cmd, "colorscheme " .. default_colorscheme)
	end

	-- background transparancy
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

setup_colorscheme()
setup_keymap()
SafeRequire("catppuccin", function(catppuccin)
	vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

	catppuccin.setup({
		-- integrations = {
		--
		-- },
	})
end)
