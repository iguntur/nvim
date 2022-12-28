local function setup_null_ls(nls)
	-- sources
	local sources = {
		nls.builtins.code_actions.gitsigns,

		nls.builtins.formatting.stylua,
		nls.builtins.formatting.prettier.with({
			prefer_local = "node_modules/.bin",
		}),

		-- nls.builtins.diagnostics.eslint,
		-- nls.builtins.completion.spell,
	}

	local function lsp_formatting(bufnr)
		if vim.version().minor == 7 then
			-- vim.lsp.buf.formatting_sync()
			vim.lsp.buf.formatting_seq_sync(nil, 1000, { "null-ls" })

			return
		end

		-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
		if vim.version().minor == 8 then
			vim.lsp.buf.format({
				bufnr = bufnr,
				filter = function(client)
					-- apply whatever logic you want (in this example, we'll only use null-ls)
					return client.name == "null-ls"
				end,
			})
		end
	end

	-- if you want to set up formatting on save, you can use this as a callback
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	-- add to your shared on_attach callback
	local function on_attach(client, bufnr)
		-- format on save
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end

	nls.setup({
		sources = sources,
		on_attach = on_attach,
	})
end

SafeRequire("null-ls", setup_null_ls)
SafeRequire("mason-null-ls", function(mason_null_ls)
	mason_null_ls.setup({
		ensure_installed = {
			"jq",
			"prettier",
			"stylua",
		},
	})
end)