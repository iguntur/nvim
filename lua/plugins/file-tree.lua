return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        keys = {
            {
                "<leader>F",
                function()
                    vim.cmd([[ Neotree focus ]])
                end,
                desc = "Focus on file-tree",
            },
            {
                "<leader>a",
                function()
                    vim.cmd([[ Neotree toggle ]])
                end,
                desc = "Toggle file-tree (Neotree)",
            },
        },
    },
}
