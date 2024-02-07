return {
    {
        "LazyVim/LazyVim",
        opts = {
            -- colorscheme = "solarized-osaka",
            colorscheme = "tokyonight",
        },
    },

    {
        "folke/tokyonight.nvim",
        opts = {
            style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            -- light_style = "day", -- The theme is used when the background is set to light
            transparent = true, -- Enable this to disable setting the background color
        },
    },

    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true, -- disables setting the background color.
            show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
            term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        },
    },

    {
        "craftzdog/solarized-osaka.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            transparent = true,
        },
    },

    --
    -- bufferline: tab like
    --
    {
        "akinsho/bufferline.nvim",
        enabled = false,
        keys = {
            { "<M-]>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
            { "<M-[>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
            { "<M-}>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer to the right" },
            { "<M-{>", "<cmd>BufferLineMovePrev<cr>", desc = "Prev buffer to the left" },
        },
    },

    --
    -- indent guides for Neovim
    --
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     event = "LazyFile",
    --     main = "ibl",
    --     config = function()
    --         local hooks = require("ibl.hooks")
    --         local highlight = {
    --             "RainbowGreen",
    --             "RainbowBlue",
    --             "RainbowYellow",
    --             "RainbowOrange",
    --             "RainbowCyan",
    --             "RainbowViolet",
    --             "RainbowRed",
    --         }
    --
    --         -- create the highlight groups in the highlight setup hook, so they are reset
    --         -- every time the colorscheme changes
    --         hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    --             vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#72f5b5" })
    --             vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    --             vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    --             vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    --             vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    --             vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    --             vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#CE006B" })
    --         end)
    --
    --         require("ibl").setup({
    --             indent = {
    --                 char = "▏",
    --                 tab_char = "▏",
    --                 highlight = highlight,
    --             },
    --             scope = {
    --                 char = "▏",
    --                 -- char = "█",
    --                 highlight = highlight,
    --                 enabled = false,
    --             },
    --             whitespace = {
    --                 highlight = highlight,
    --                 remove_blankline_trail = true,
    --             },
    --         })
    --     end,
    -- },

    -- {
    --     "echasnovski/mini.indentscope",
    --     opts = {
    --         symbol = "▏",
    --         -- symbol = "│",
    --         -- symbol = "█",
    --     },
    -- },

    --
    -- status line
    --
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function(_, opts)
            local config = {
                theme = "auto",
            }

            opts.options = vim.tbl_extend("force", opts.options or {}, config)
        end,
    },

    -- {
    --     "utilyre/barbecue.nvim",
    --     name = "barbecue",
    --     version = "*",
    --     dependencies = {
    --         "SmiteshP/nvim-navic",
    --         "nvim-tree/nvim-web-devicons", -- optional dependency
    --     },
    --     opts = {
    --         -- configurations go here
    --     },
    -- },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim",
                },
                opts = {
                    lsp = {
                        auto_attach = true,
                    },
                },
            },
        },
    },
}
