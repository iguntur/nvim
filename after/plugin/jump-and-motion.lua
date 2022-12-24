local keymap = vim.keymap.set

local function lightspeed_setup(lightspeed)
	lightspeed.setup()
end

local function leap_setup(leap)
	leap.add_default_mappings()
end

local function quick_scope_setup()
	-- unblevable/quick-scope
	-- Trigger a highlight only when pressing f and F.
	vim.g.qs_highlight_on_keys = { "f", "F" }
end

local function hop_setup(hop)
	-- you can configure Hop the way you like here; see :h hop-config
	hop.setup({})

	keymap("n", "<leader>jw", ":HopWord<CR>", {})
	keymap("n", "<leader>jp", ":HopPattern<CR>", {})
end

SafeRequire("hop", hop_setup)
SafeRequire("leap", leap_setup)
-- SafeRequire("lightspeed", lightspeed_setup)

-- quick_scope_setup()
