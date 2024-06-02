return {
    --
    -- lsp config
    --
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
            { "mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        opts = {
            -- provide the inlay hints.
            -- inlay_hints = {
            --     enabled = true,
            -- },

            -- document_highlight = {
            --     enabled = false,
            -- },

            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            servers = {
                -- gopls = {
                --     settings = {
                --         gopls = {},
                --     },
                -- },
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
        keys = {
            { "<space>lr", "<cmd>LspRestart<cr>", desc = "Restart LSP Engine" },
        },
    },
}
