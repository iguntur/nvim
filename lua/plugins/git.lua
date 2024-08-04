return {
    --
    -- A Git wrapper so awesome
    --
    {
        "tpope/vim-fugitive",
    },

    --
    --
    --
    {
        "sindrets/diffview.nvim",
        opts = {},
    },

    --
    -- gitsigns
    --
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            attach_to_untracked = true,
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            -- current_line_blame_opts = {
            -- 	virt_text = true,
            -- 	virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            -- 	delay = 1000,
            -- 	ignore_whitespace = false,
            -- },
            -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            -- current_line_blame_formatter = "    <author>, <author_time:%Y-%m-%d> - <summary>",
        },
        keys = {
            { "<M-,>", "<cmd>Gitsigns next_hunk<cr>zz", silent = true, noremap = true, desc = "Next hunk" },
            { "<M-.>", "<cmd>Gitsigns prev_hunk<cr>zz", silent = true, noremap = true, desc = "Previous hunk" },
            { "<space>gr", "<cmd>Gitsigns refresh<cr>zz", silent = true, noremap = true, desc = "Refresh git signs" },
        },
    },

    --
    -- Git worktree
    --
    {
        "ThePrimeagen/git-worktree.nvim",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("telescope").load_extension("git_worktree")
        end,
        keys = {
            {
                "<leader>gwa",
                function()
                    local branch = vim.fn.input("Add: ")
                    require("git-worktree").create_worktree(branch, branch, "origin")
                end,
                desc = "Create a new worktree",
            },
            {
                "<leader>gws",
                function()
                    vim.cmd("silent !tmux neww -t 0 gw-switch")
                end,
                desc = "Switch to a worktree branch",
            },
            {
                "<leader>gwd",
                function()
                    local branch = vim.fn.input("Delete: ")
                    require("git-worktree").delete_worktree(branch)
                end,
                desc = "Delete a worktree branch",
            },
        },
    },
}
