return {
    {
        "stevearc/conform.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        opts = function()
            local opts = {
                -- LazyVim will use these options when formatting with the conform.nvim formatter
                format = {
                    timeout_ms = 3000,
                    async = false, -- not recommended to change
                    quiet = false, -- not recommended to change
                    lsp_fallback = true, -- not recommended to change
                },

                formatters_by_ft = {
                    lua = { "stylua" },
                    fish = { "fish_indent" },
                    sh = { "shfmt" },
                    -- Conform will run multiple formatters sequentially
                    python = { "isort", "black" },
                    -- Use a sub-list to run only the first available formatter
                    go = {
                        "gofumpt",
                        "goimports-reviser",
                        "golines",
                    },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    svelte = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    graphql = { "prettier" },
                },

                formatters = {
                    injected = { options = { ignore_errors = true } },
                    golines = {
                        prepend_args = { "--max-len=250" },
                    },
                },
            }

            return opts
        end,
    },
}
