return {
    {
        "olexsmir/gopher.nvim",
        dependencies = { -- dependencies
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },

    --
    -- go
    --
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "nvim-treesitter/nvim-treesitter",
            {
                "neovim/nvim-lspconfig",
                event = "LazyFile",
                opts = {
                    document_highlight = {
                        enabled = false,
                    },

                    servers = {
                        gopls = {
                            settings = {
                                gopls = {
                                    buildFlags = { "-tags", "wireinject" },
                                },
                            },

                            keys = {
                                { "<leader>cr", "<cmd>GoRename<CR>", desc = "Rename References" },
                            },
                        },
                    },
                },
            },
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = {
            "go",
            "gomod",
            -- "gowork",
        },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
}
