return {
    --
    -- tokyonight
    --
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            transparent = true, -- Enable this to disable setting the background color
            -- light_style = "day", -- The theme is used when the background is set to light
            -- dim_inactive = true, -- dims inactive windows
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
            on_highlights = function(hl, c)
                -- remove telescope background
                hl.TelescopeNormal = { bg = "NONE" }
                hl.TelescopeBorder = { bg = "NONE" }
                hl.TelescopePromptNormal = { bg = "NONE" }
                hl.TelescopePromptBorder = { bg = "NONE" }
                hl.TelescopePromptTitle = { bg = "NONE" }
                hl.TelescopePreviewTitle = { bg = "NONE" }
                hl.TelescopePreviewBorder = { bg = "NONE" }
                hl.TelescopeResultsTitle = { bg = "NONE" }
                hl.TelescopeResultsBorder = { bg = "NONE" }
            end,

            ---@type table<string, boolean|{enabled:boolean}>
            -- plugins = {
            --     -- telescope = true,
            -- },
        },
    },

    --
    -- catppuccin
    --
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            -- flavour = "auto", -- auto, latte, frappe, macchiato, mocha
            -- background = { -- :h background
            --     light = "latte",
            --     dark = "mocha",
            -- },
            transparent_background = true, -- disables setting the background color.
            show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
            -- term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        },
    },

    --
    -- ayu
    --
    {
        "Shatur/neovim-ayu",
        config = function()
            require("ayu").setup({
                mirage = true,
                terminal = true, -- Set to `false` to let terminal manage its own colors.
                overrides = {
                    Normal = { bg = "None" },
                    ColorColumn = { bg = "None" },
                    SignColumn = { bg = "None" },
                    Folded = { bg = "None" },
                    FoldColumn = { bg = "None" },
                    CursorLine = { bg = "None" },
                    CursorColumn = { bg = "None" },
                    WhichKeyFloat = { bg = "None" },
                    VertSplit = { bg = "None" },
                }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
            })
        end,
    },
}
