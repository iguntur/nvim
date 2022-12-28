local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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

	-- format on save
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

	nls.setup({
		sources = sources,
		on_attach = on_attach,
	})
end

SafeRequire("null-ls", setup_null_ls)
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
