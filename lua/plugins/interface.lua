return {
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

    {
        "echasnovski/mini.indentscope",
        opts = {
            -- symbol = "▏",
            symbol = "│",
            -- symbol = "█",
            options = { try_as_border = true },
        },
    },

    --
    -- status line
    --
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function(_, opts)
            local config = {
                theme = "auto",
                -- theme = "moonfly",
                section_separators = {
                    left = "",
                    right = "",
                },
                component_separators = {
                    left = "",
                    right = "",
                },
            }

            opts.options = vim.tbl_deep_extend("force", opts.options or {}, config)
        end,
    },

    --
    -- navbuddy like
    --
    {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
        },
        opts = function(_, opts)
            local actions = require("nvim-navbuddy.actions")

            local options = {
                lsp = {
                    auto_attach = true,
                },
                window = {
                    -- border = "single", -- "rounded", "double", "solid", "none"
                    -- or an array with eight chars building up the border in a clockwise fashion
                    -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
                    size = "98%", -- Or table format example: { height = "40%", width = "100%"}
                    -- position = "50%", -- Or table format example: { row = "100%", col = "0%"}
                    -- scrolloff = nil, -- scrolloff value within navbuddy window
                    sections = {
                        left = {
                            size = "20%",
                            -- border = nil, -- You can set border style for each section individually as well.
                        },
                        mid = {
                            size = "30%",
                            -- border = nil,
                        },
                        right = {
                            -- No size option for right most section. It fills to
                            -- remaining area.
                            border = nil,
                            preview = "leaf", -- Right section can show previews too.
                            -- Options: "leaf", "always" or "never"
                        },
                    },
                },
                mappings = {
                    ["t"] = actions.telescope({ -- Fuzzy finder at current level.
                        layout_strategy = "horizontal",
                        layout_config = { -- All options that can be
                            prompt_position = "top",
                            height = 500, -- passed to telescope.nvim's
                            width = 500, -- default can be passed here.
                            preview_width = 110,
                        },
                    }),
                },
            }

            return vim.tbl_deep_extend("force", opts, options)
        end,
        keys = {
            {
                "<space>sn",
                "<cmd>Navbuddy<cr>",
                silent = true,
                noremap = true,
                desc = "Navbuddy toggle",
            },
        },
    },

    --
    -- winbar feature
    --
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            ---Whether to replace file icon with the modified symbol when buffer is modified.
            ---@type boolean
            show_modified = true,
        },
    },
}
