return {
    {
        "numToStr/Comment.nvim",
        opts = {
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        },
        lazy = false,
        keys = {
            { "<C-_>", "gcc<Esc>", mode = { "n" }, desc = "Comment line", remap = true },
            { "<C-_>", "gc<Esc>gv", mode = { "v" }, desc = "Comment line", remap = true },
            { "<C-_>", "<Esc>gcc<Esc>", mode = { "i" }, desc = "Comment line", remap = true },
        },
    },

    -- buffer remove
    {
        "echasnovski/mini.bufremove",
        keys = {
            { "<M-w>", "<leader>bd", desc = "Delete buffer", remap = true },
            { "<M-W>", "<leader>bD", desc = "Delete buffer (Force)", remap = true },
        },
    },

    -- git
    {
        "lewis6991/gitsigns.nvim",
        keys = {
            { "<M-,>", "]h", remap = true, desc = "Next hunk" },
            { "<M-.>", "[h", remap = true, desc = "Previous hunk" },
        },
    },

    --
    -- neoscroll - smooth scrolling
    --
    {
        "karb94/neoscroll.nvim",
        opts = {
            -- known issues: <C-u>, <C-d>, <C-b>, <C-f> mess up macros (issue). see: https://github.com/karb94/neoscroll.nvim/issues/9
            mappings = { "<C-y>", "<C-e>", "zt", "zz", "zb" },
        },
        keys = {
            {
                "<C-j>",
                function()
                    require("neoscroll").scroll(10, true, 250)
                end,
                mode = { "n", "x" },
                silent = true,
            },
            {
                "<C-k>",
                function()
                    require("neoscroll").scroll(-10, true, 250)
                end,
                mode = { "n", "x" },
                silent = true,
            },
        },
    },
}
