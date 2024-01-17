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
        },
    },
}
