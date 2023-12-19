return {
    {
        "nvim-telescope/telescope.nvim",
        opts = function()
            return {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--follow",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--no-ignore",
                        "--hidden",
                        "--ignore-file",
                        vim.env.HOME .. "/.rgignore",
                        "--sort",
                        "path",
                        -- "-u", -- alias for --unrestricted
                        -- "--trim" -- add this value
                    },
                    layout_strategy = "bottom_pane", -- vertical, horizontal, flex, bottom_pane
                    layout_config = {
                        prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                },
            }
        end,
    },
}
