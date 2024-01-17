return {
    {
        "nvimtools/none-ls.nvim",
        opts = function(_, opts)
            local nls = require("null-ls")

            opts.root_dir = opts.root_dir
                or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")

            opts.sources = vim.list_extend(opts.sources or {}, {
                --
                -- diagnostics
                --
                nls.builtins.diagnostics.fish,
                -- nls.builtins.diagnostics.eslint,
                -- nls.builtins.diagnostics.markdownlint,

                --
                -- code actions
                --
                nls.builtins.code_actions.gitsigns,

                --
                -- formatting
                --
                nls.builtins.formatting.fish_indent,
                nls.builtins.formatting.shfmt,
                nls.builtins.formatting.stylua,
                nls.builtins.formatting.prettier.with({
                    prefer_local = "node_modules/.bin",
                    -- extra_filetypes = { "toml" },
                }),
                nls.builtins.formatting.taplo,
                nls.builtins.formatting.gofumpt,
                -- nls.builtins.formatting.goimports,
                nls.builtins.formatting.goimports_reviser,
                nls.builtins.formatting.golines.with({
                    extra_args = { "-m", 300 },
                }),
            })
        end,
    },
}
