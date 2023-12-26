return {
    --
    -- A Git wrapper so awesome
    --
    {
        "tpope/vim-fugitive",
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
