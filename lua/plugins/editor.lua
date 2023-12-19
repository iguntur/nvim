return {
    --
    -- comment
    --
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

    --
    -- buffer remove
    --
    {
        "echasnovski/mini.bufremove",
        keys = {
            { "<M-w>", "<leader>bd", desc = "Delete buffer", remap = true },
            { "<M-W>", "<leader>bD", desc = "Delete buffer (Force)", remap = true },
        },
    },

    --
    -- git
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

    --
    -- join and split text line
    --
    {
        "AndrewRadev/splitjoin.vim",
        lazy = true,
        version = "^1.0.0",
        -- split and join keymaps:
        -- gS - to split a one-liner into multiple lines
        -- gJ - (with the cursor on the first line of a block) to join a block into a single-line statement.
    },

    --
    -- numb: realtime go to linenumber
    --
    {
        "nacro90/numb.nvim",
        opts = {},
    },
}
