local LazyUtil = require("lazyvim.util")

return {
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
        enabled = false,
        opts = {
            overrides = {
                complex = {
                    -- Set the filetype of any full filename matching the regex to gitconfig
                    [".*git/config"] = "gitconfig", -- Included in the plugin
                    [".env"] = "sh",
                    -- [".env.*"] = "sh",
                    -- ["*.env.*"] = "sh",
                    ["tsconfig*.json"] = "jsonc",
                    ["Dockerfile.*"] = "dockerfile",
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
                            ".env",
                            ".env.*",
                            "*.env",
                            ".*.env",
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
    -- Nvim Context VT: end of context line or scope
    --
    {
        "andersevenrud/nvim_context_vt",
        opts = {
            -- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
            -- Default: true
            enabled = true,

            -- Override default virtual text prefix
            -- Default: '-->'
            prefix = "",
        },
    },

    --
    -- illuminate: goto next/previous reference
    --
    {
        "RRethy/vim-illuminate",
        event = "LazyFile",
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, direction, buffer)
                local key_options = {
                    desc = direction:sub(1, 1):upper() .. direction:sub(2) .. " Reference",
                    buffer = buffer,
                }

                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. direction .. "_reference"](false)
                end, key_options)
            end

            map("<M-n>", "next")
            map("<M-m>", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("<M-n>", "next", buffer)
                    map("<M-m>", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "<M-n>", desc = "Next Reference" },
            { "<M-m>", desc = "Prev Reference" },
        },
    },

    --
    -- indent-o-matic
    --
    {
        "Darazaki/indent-o-matic",
        opts = {},
    },

    -- Lua
    {
        "folke/twilight.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<space>tw",
                ":Twilight<CR>",
                noremap = true,
                silent = true,
                desc = "Twilight toggle",
            },
        },
    },
}
