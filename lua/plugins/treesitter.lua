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
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
            },
            autotag = { -- "windwp/nvim-ts-autotag" Use treesitter to autoclose and autorename html tag
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
                "[x",
                function()
                    require("treesitter-context").go_to_context(vim.v.count1)
                end,
                desc = "Go to header context",
            },
        },
    },
}
