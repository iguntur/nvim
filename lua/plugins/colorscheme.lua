return {
    --
    -- tokyonight
    --
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            -- light_style = "day", -- The theme is used when the background is set to light
            transparent = true, -- Enable this to disable setting the background color
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
