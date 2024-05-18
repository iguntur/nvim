return {
    --
    -- lsp config
    --
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
            { "folke/neodev.nvim", opts = {} },
            { "mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        opts = {
            -- provide the inlay hints.
            -- inlay_hints = {
            --     enabled = true,
            -- },

            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            servers = {
                lua_ls = {
                    -- mason = false, -- set to false if you don't want this server to be installed with mason
                    -- Use this to add any additional keymaps
                    -- for specific lsp servers
                    ---@type LazyKeysSpec[]
                    -- keys = {},
                    settings = {
                        Lua = {
                            hint = { enable = true },
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
                tsserver = {
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
                                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
                                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                    },
                },
            },
        },
    },

    --
    -- none-ls: previously known as null-ls
    --
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
                -- nls.builtins.formatting.taplo,
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
