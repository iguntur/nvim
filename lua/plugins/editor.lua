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
        -- opts = {
        --     -- known issues: <C-u>, <C-d>, <C-b>, <C-f> mess up macros (issue). see: https://github.com/karb94/neoscroll.nvim/issues/9
        --     mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        -- },
        config = function()
            require("neoscroll").setup({})
        end,
        keys = {
            {
                "<C-n>",
                function()
                    require("neoscroll").scroll(10, true, 250)
                    vim.cmd("normal! zzzv")
                end,
                mode = { "n", "x" },
                remap = true,
                silent = true,
            },
            {
                "<C-m>",
                function()
                    require("neoscroll").scroll(-10, true, 250)
                    vim.cmd("normal! zzzv")
                end,
                mode = { "n", "x" },
                remap = true,
                silent = true,
            },
        },
    },

    --
    -- join and split text line
    --
    {
        "Wansmer/treesj",
        opts = {
            max_join_length = 800,
        },
        keys = {
            {
                "<space>m",
                function()
                    require("treesj").toggle()
                end,
                desc = "Split and join code block (toggle)",
            },
            {
                "<space>M",
                function()
                    require("treesj").toggle({ split = { recursive = true } })
                end,
                desc = "Split and join code block recursively (toggle)",
            },
        },
    },
    -- {
    --     "AndrewRadev/splitjoin.vim",
    --     version = "^1.0.0",
    --     -- split and join keymaps:
    --     -- gS - to split a one-liner into multiple lines
    --     -- gJ - (with the cursor on the first line of a block) to join a block into a single-line statement.
    -- },

    --
    -- numb: realtime go to linenumber
    --
    {
        "nacro90/numb.nvim",
        opts = {},
    },
}
