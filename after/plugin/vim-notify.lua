SafeRequire("notify", function(notify)
	notify.setup({
		background_colour = "#000000",
	})

	vim.notify = notify
end)
