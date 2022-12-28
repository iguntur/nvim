local function setup_undotree()
	vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end

setup_undotree()
