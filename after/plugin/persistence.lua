SafeRequire("persistence", function(persistence)
	-- restore the session for the current directory
	vim.keymap.set("n", "<leader>qs", function()
		persistence.load()
	end, { silent = true })

	-- restore the last session
	vim.keymap.set("n", "<leader>ql", function()
		persistence.load({ last = true })
	end, { silent = true })

	-- stop Persistence => session won't be saved on exit
	vim.keymap.set("n", "<leader>qd", function()
		persistence.stop()
	end, { silent = true })
end)
