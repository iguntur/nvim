local M = {}

local function n_map(lhs, rhs)
	vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = true })
end

local function setup_keymap()
	n_map("<Leader>kt", "<cmd>Telescope colorscheme<CR>")
end

M.setup = function(use)
	use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }) -- gruvbox
	use("EdenEast/nightfox.nvim") -- nightfox, nordfox, dayfox, dawnfox and duskfox
	use("folke/tokyonight.nvim") -- tokyonight
	use("shaunsingh/moonlight.nvim") -- moonlight
	use("Shatur/neovim-ayu") -- ayu-<dark,light,mirage>
	-- use('glepnir/zephyr-nvim') -- zephyr
	-- use('ray-x/aurora') -- aurora
	use("RRethy/nvim-base16") -- base-16-<color-name>
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- local colorscheme = "gruvbox"
	-- local colorscheme = "catppuccin"
	local colorscheme = "ayu-mirage"

	SafeRequire("catppuccin", function(catppuccin)
		vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

		catppuccin.setup({
			-- integrations = {
			--
			-- },
		})
	end)

	local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

	if not ok then
		vim.notify('colorscheme "' .. colorscheme .. '" not installed yet')
		return
	end

	setup_keymap()
end

return M
