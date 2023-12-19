return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        keys = {
            {
                "<leader>.",
                function()
                    vim.cmd([[ Neotree focus ]])
                end,
                desc = "Focus on file-tree",
            },
            {
                "<leader>\\",
                function()
                    vim.cmd([[ Neotree toggle ]])
                end,
                desc = "Toggle file-tree (Neotree)",
            },
        },
    },
}
