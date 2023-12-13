local function setup_null_ls(null_ls)
	-- sources
	local sources = {
		--
		-- code actions
		--
		null_ls.builtins.code_actions.gitsigns,
		-- null_ls.builtins.code_actions.gomodifytags,
		-- null_ls.builtins.code_actions.refactoring,

		--
		-- formatting
		--
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			prefer_local = "node_modules/.bin",
			-- extra_filetypes = { "toml" },
		}),
		null_ls.builtins.formatting.taplo,
		-- null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.formatting.golines.with({
			extra_args = { "-m", 300 },
		}),

		--
		-- misc
		--
		-- nls.builtins.diagnostics.eslint,

		--
		-- completion
		--
		-- nls.builtins.completion.spell,
		-- null_ls.builtins.completion.luasnip,
	}

	-- format on save
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	local function on_attach(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function()
							-- apply whatever logic you want (in this example, we'll only use null-ls)
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end
	end

	-- nls.setup({
	-- 	sources = sources,
	-- 	on_attach = on_attach,
	-- })

	return {
		sources = sources,
		on_attach = on_attach,
	}
end

return function()
	local nls = require("null-ls")

	return setup_null_ls(nls)
end

-- SafeRequire("mason-null-ls", function(mason_null_ls)
-- 	mason_null_ls.setup({
-- 		automatic_setup = false,
-- 		ensure_installed = {
-- 			"jq",
-- 			"prettier",
-- 			-- "stylua",
-- 		},
-- 	})
-- end)
