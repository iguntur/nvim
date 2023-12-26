SafeRequire("gitsigns", function(gitsigns)
	gitsigns.setup({
		attach_to_untracked = true,
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		-- current_line_blame_opts = {
		-- 	virt_text = true,
		-- 	virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		-- 	delay = 1000,
		-- 	ignore_whitespace = false,
		-- },
		-- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
		-- current_line_blame_formatter = "    <author>, <author_time:%Y-%m-%d> - <summary>",

		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local function map(mode, l, r, opts)
				opts = opts or {}

				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			--
			-- 	-- Navigation
			map("n", "<M-,>", function()
				if vim.wo.diff then
					return "<M-,>"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			map("n", "<M-.>", function()
				if vim.wo.diff then
					return "<M-.>"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })
		end,
	})

	-- vim.keymap.set("n", "<M-.>", "<cmd>Gitsigns next_hunk<CR>")
	-- vim.keymap.set("n", "<M-,>", "<cmd>Gitsigns prev_hunk<CR>")
end)