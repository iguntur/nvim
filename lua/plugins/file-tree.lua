return {
    --
    -- neo-tree: file explorer
    --
    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = false,
        keys = {
            {
                "<leader>.",
                function()
                    vim.cmd([[ Neotree focus ]])
                end,
                desc = "Focus on file-tree",
            },
        },
    },

    --
    -- nvim-tree: file explorer
    --
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                -- sort_by = "case_sensitive",
                view = {
                    adaptive_size = true,
                    -- mappings = {
                    -- 	list = {
                    -- 		{ key = "u", action = "dir_up" },
                    -- 	},
                    -- },
                },
                renderer = {
                    -- add_trailing = false,
                    -- group_empty = false,
                    highlight_git = true,
                    -- full_name = false,
                    highlight_opened_files = "all", -- "none", "icon" "name" "all"
                    -- root_folder_modifier = ":~",
                    root_folder_label = true,
                    indent_markers = {
                        enable = true,
                    },
                },
                filters = {
                    dotfiles = true,
                    -- custom = {},
                    -- exclude = {},
                },
                git = {
                    -- enable = true,
                    ignore = false,
                    -- timeout = 400,
                },
            })

            vim.keymap.set("n", "<space>ff", "<cmd>NvimTreeFindFile<cr>", {
                silent = true,
                noremap = true,
                desc = "Toggle find file on file-tree",
            })

            vim.keymap.set("n", "<space>fe", "<cmd>NvimTreeFindFileToggle<cr>", {
                silent = true,
                noremap = true,
                desc = "Find current file on file-tree",
            })
        end,
    },
}
