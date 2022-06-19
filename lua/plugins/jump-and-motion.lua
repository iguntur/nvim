local keymap = vim.api.nvim_set_keymap

local M = {}

-- local function sneak_setup()
-- 	-- Settings
-- 	-- vim.g["sneak#label"] = 1

-- 	-- keymap("n", "<leader>s", "<Plug>Sneak_s", { silent = true }) -- jump forward
-- 	-- keymap("n", "<leader>S", "<Plug>Sneak_S", { silent = true }) -- jump backward
-- end

local function lightspeed_setup(lightspeed)
	local should_setup = false

	if should_setup then
		lightspeed.setup()
	end
end

local function quick_scope_setup()
	-- unblevable/quick-scope
	local should_setup = false

	if should_setup then
		vim.g.qs_highlight_on_keys = { "f", "F" } -- Trigger a highlight only when pressing f and F.
	end
end

local function hop_setup(hop)
	-- you can configure Hop the way you like here; see :h hop-config
	hop.setup({})

	keymap("n", "<leader>jw", ":HopWord<CR>", { noremap = true, silent = true })
	keymap("n", "<leader>jp", ":HopPattern<CR>", { noremap = true, silent = true })
end

M.setup = function(use)
	-- use("justinmk/vim-sneak") -- Jump to any location specified by two characters.
	use("unblevable/quick-scope") -- Quick jump with f/F
	use("ggandor/lightspeed.nvim")
	use("phaazon/hop.nvim")

	quick_scope_setup()
	SafeRequire("lightspeed", lightspeed_setup)
	SafeRequire("hop", hop_setup)
end

return M
