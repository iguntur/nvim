return {
    --
    -- luarocks
    --
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },

    --
    -- neorg
    --
    {
        "nvim-neorg/neorg",
        dependencies = {
            "luarocks.nvim",
        },
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        build = ":Neorg sync-parsers",
        config = function()
            local neorg = require("neorg")

            neorg.setup({
                load = {
                    -- Loads default behaviour
                    ["core.defaults"] = {},
                    ["core.keybinds"] = {
                        config = {
                            default_keybinds = true,
                        },
                    },

                    -- journals

                    -- dirman
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                -- Format: <name_of_workspace> = <path_to_workspace_root>
                                personal = "~/dev/notes/guntur",
                                efishery = "~/dev/notes/efishery",
                                ruangguru = "~/dev/notes/ruangguru",
                            },
                            default_workspace = "personal",
                            index = "index.norg", -- The name of the main (root) .norg file
                        },
                    },

                    -- Adds pretty icons to your documents
                    ["core.concealer"] = {
                        config = {
                            icons = {
                                code_block = {
                                    conceal = true,
                                },
                            },
                        },
                    },

                    -- ["external.kanban"] = {},
                    -- ["core.ui.calendar"] = {},
                },
            })
        end,
    },
}
