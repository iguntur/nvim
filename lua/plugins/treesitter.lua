return {
    --
    -- treesetter core
    --
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            { "theHamsta/nvim-treesitter-pairs" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
        opts = {
            pairs = { -- "theHamsta/nvim-treesitter-pairs"
                enable = true,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
                },
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        keys = {
            {
                "[0",
                function()
                    require("treesitter-context").go_to_context()
                end,
                desc = "Go to header context",
            },
        },
    },
}
