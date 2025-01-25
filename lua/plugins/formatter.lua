return {
    {
        "stevearc/conform.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        opts = function(_, opts)
            local local_options = {
                formatters_by_ft = {
                    -- Conform will run multiple formatters sequentially
                    python = { "isort", "black" },
                    go = {
                        "gofumpt",
                        "goimports-reviser",
                        "golines",
                    },
                    svelte = { "prettier", "rustywind" },
                    templ = { "templ", "rustywind" },
                    php = { "pint" },
                    blade = { "blade-formatter", "rustywind" },
                    nix = { "nixfmt" },
                },

                formatters = {
                    injected = { options = { ignore_errors = true } },
                    golines = {
                        prepend_args = { "--max-len=120" },
                    },
                },
            }

            opts = vim.tbl_deep_extend("force", opts, local_options)

            return opts
        end,
    },
}
