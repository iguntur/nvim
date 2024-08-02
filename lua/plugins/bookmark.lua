return {
    --
    -- bookmarks
    --
    {
        "chentoast/marks.nvim",
        config = function()
            local marks = require("marks")
            local config = {
                -- whether the shada file is updated after modifying uppercase marks. default false
                force_write_shada = true,
                mappings = {
                    next = "<M-L>",
                    prev = "<M-H>", -- pass false to disable only this default mapping
                },
            }

            marks.setup(config)

            local function keymap_opts(opts)
                return vim.tbl_deep_extend("force", { noremap = true, silent = true }, opts)
            end

            vim.keymap.set(
                "n",
                "<space>bqa",
                ":MarksQFListAll<CR>",
                keymap_opts({
                    desc = "[B]ookmarks [Q]uickfixlist [A]ll",
                })
            )
        end,
    },

    --    --
    --    -- bookmarks
    --    --
    --    {
    --        "tomasky/bookmarks.nvim",
    --        dependencies = {
    --            { "nvim-telescope/telescope.nvim" },
    --        },
    --        event = "VimEnter",
    --        config = function()
    --            local bm = require("bookmarks")
    --
    --            bm.setup({
    --                -- sign_priority = 8,  --set bookmark sign priority to cover other sign
    --                save_file = vim.fn.expand("$HOME/.config/nvim/.cache/bookmarks"), -- bookmarks save file path
    --                on_attach = function(_)
    --                    vim.keymap.set("n", "mm", bm.bookmark_toggle, {
    --                        noremap = true,
    --                        silent = true,
    --                        desc = "Add or remove bookmark at current line",
    --                    })
    --                    vim.keymap.set("n", "mi", bm.bookmark_ann, {
    --                        noremap = true,
    --                        silent = true,
    --                        desc = "Add or edit mark annotation at current line",
    --                    })
    --                    vim.keymap.set("n", "mc", bm.bookmark_clean, {
    --                        noremap = true,
    --                        silent = true,
    --                        desc = "Clean all marks in current buffer",
    --                    })
    --                    vim.keymap.set("n", "mx", bm.bookmark_clear_all, {
    --                        noremap = true,
    --                        silent = true,
    --                        desc = "Clear all bookmarks",
    --                    })
    --                    vim.keymap.set("n", "mn", bm.bookmark_next, {
    --                        noremap = true,
    --                        silent = true,
    --                        desc = "Jump to next mark in current buffer",
    --                    })
    --                    vim.keymap.set("n", "mp", bm.bookmark_prev, {
    --                        noremap = true,
    --                        silent = true,
    --                        desc = "Jump to previous mark in current buffer",
    --                    })
    --                    vim.keymap.set("n", "ml", require("telescope").extensions.bookmarks.list, {
    --                        noremap = true,
    --                        silent = true,
    --                        desc = "Show marked files in bookmark lists",
    --                    })
    --                end,
    --            })
    --
    --            LazyUtil.on_load("telescope.nvim", function()
    --                require("telescope").load_extension("bookmarks")
    --            end)
    --        end,
    --    },
    --
}
