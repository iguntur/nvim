local M = {}

local function setup_nls()
	SafeRequire("null-ls", function(nls)
		local formatting = nls.builtins.formatting
		-- local diagnostic = nls.builtins.diagnostic

		-- sources
		local sources = {
			nls.builtins.code_actions.gitsigns,

			-- formatting.stylua,
			formatting.prettier.with({
				prefer_local = "node_modules/.bin",
			}),

			-- nls.builtins.diagnostics.eslint,
			-- nls.builtins.completion.spell,
		}

		local on_attach = function(client)
			-- format on save
			if client.resolved_capabilities.document_formatting then
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
			end
		end

		nls.setup({
			sources = sources,
			on_attach = on_attach,
		})
	end)
end

M.setup = function(use)
	use("jose-elias-alvarez/null-ls.nvim")

	setup_nls()
end

return M
