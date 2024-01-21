local LazyUtil = require("lazyvim.util")

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
            require("neoscroll").setup({
                mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
            })
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

    --
    -- filetype
    --
    {
        "nathom/filetype.nvim",
        opts = {
            overrides = {
                complex = {
                    -- Set the filetype of any full filename matching the regex to gitconfig
                    [".*git/config"] = "gitconfig", -- Included in the plugin
                    [".env.*"] = "sh",
                    ["tsconfig*.json"] = "jsonc",
                    ["Dockerfile.*"] = "dockerfile",
                    -- ["*.sql"] = "sql",
                },
            },
        },
    },

    --
    -- cloack
    --
    {
        "laytan/cloak.nvim",
        config = function()
            require("cloak").setup({
                enabled = true,
                cloak_character = "*",
                -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
                highlight_group = "Comment",
                patterns = {
                    {
                        -- Match any file starting with '.env'.
                        -- This can be a table to match multiple file patterns.
                        file_pattern = {
                            ".env*",
                            "*.env*",
                            -- "*.toml",
                        },
                        cloak_pattern = "=.+",
                    },
                    -- {
                    --     file_pattern = {
                    --         "*.yaml",
                    --     },
                    --     -- Match an equals sign and any character after it.
                    --     -- This can also be a table of patterns to cloak,
                    --     -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
                    --     cloak_pattern = {
                    --         ":.+",
                    --         "-.+",
                    --     },
                    -- },
                },
            })

            vim.keymap.set("n", "<space>ee", "<cmd>CloakToggle<cr>", {
                silent = true,
                desc = "Toggle cloak env secret",
            })
        end,
    },

    --
    -- bookmarks
    --
    {
        "tomasky/bookmarks.nvim",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
        },
        event = "VimEnter",
        config = function()
            local bm = require("bookmarks")

            bm.setup({
                -- sign_priority = 8,  --set bookmark sign priority to cover other sign
                save_file = vim.fn.expand("$HOME/.config/nvim/.cache/bookmarks"), -- bookmarks save file path
                on_attach = function(bufnr)
                    local bm = require("bookmarks")

                    vim.keymap.set("n", "mm", bm.bookmark_toggle, {
                        silent = true,
                        desc = "Add or remove bookmark at current line",
                    })
                    vim.keymap.set("n", "mi", bm.bookmark_ann, {
                        silent = true,
                        desc = "Add or edit mark annotation at current line",
                    })
                    vim.keymap.set("n", "mc", bm.bookmark_clean, {
                        silent = true,
                        desc = "Clean all marks in current buffer",
                    })
                    vim.keymap.set("n", "mn", bm.bookmark_next, {
                        silent = true,
                        desc = "Jump to next mark in current buffer",
                    })
                    vim.keymap.set("n", "mp", bm.bookmark_prev, {
                        silent = true,
                        desc = "Jump to previous mark in current buffer",
                    })
                    vim.keymap.set("n", "ml", require("telescope").extensions.bookmarks.list, {
                        silent = true,
                        desc = "Show marked files in bookmark lists",
                    })
                end,
            })

            LazyUtil.on_load("telescope.nvim", function()
                require("telescope").load_extension("bookmarks")
            end)
        end,
    },

    --
    -- change case
    --
    {
        "johmsalas/text-case.nvim",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("textcase").setup()

            LazyUtil.on_load("telescope.nvim", function()
                require("telescope").load_extension("textcase")
            end)

            vim.keymap.set(
                "n",
                "ga.",
                "<cmd>TextCaseOpenTelescope<CR>",
                { silent = true, noremap = true, desc = "TextCase Open" }
            )
            vim.keymap.set(
                "v",
                "ga.",
                "<cmd>TextCaseOpenTelescope<CR>",
                { silent = true, noremap = true, desc = "TextCase Open" }
            )
            vim.keymap.set(
                "n",
                "gaa",
                "<cmd>TextCaseOpenTelescopeQuickChange<CR>",
                { silent = true, noremap = true, desc = "Telescope Quick Change" }
            )
            vim.keymap.set(
                "n",
                "gai",
                "<cmd>TextCaseOpenTelescopeLSPChange<CR>",
                { silent = true, noremap = true, desc = "Telescope LSP Change" }
            )
        end,
    },

    --
    -- maximize window
    --
    {
        "declancm/maximize.nvim",
        config = function()
            require("maximize").setup({ default_keymaps = false })

            vim.keymap.set("n", "<leader>z", function()
                require("maximize").toggle()
            end, { silent = true, desc = "Toggle Maximize" })
        end,
    },
}
