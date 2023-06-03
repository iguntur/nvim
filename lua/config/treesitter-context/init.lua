local function setup_keymap(tsc)
	local opts = { silent = true }

	vim.keymap.set("n", "[c", function()
		tsc.go_to_context()
	end, opts)
end

return function()
	local tsc = require("treesitter-context")

	tsc.setup()
	setup_keymap(tsc)
end
