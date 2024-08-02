return {
    {
        "rcarriga/nvim-notify",
        opts = {
            background_colour = "#000000",
        },
    },

    --
    -- noice: UI commandline, messages, etc...
    --
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        opts = {
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                            { find = "%d fewer lines" },
                            { find = "%d more lines" },
                        },
                    },
                    view = "mini",
                },
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "DB:" },
                            { find = "E475: Invalid argument" }, -- eg: tab move
                            { find = "E384: vim" }, -- (vim-illuminate)
                            { find = "E553: No more items" }, -- (quickfix list cycle)
                        },
                    },
                    opts = { skip = true },
                },
            },

            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true, -- enables an input dialog for inc-rename.nvim
                -- lsp_doc_border = false, -- add a border to hover docs and signature help
            }, --
        },
    },
}
