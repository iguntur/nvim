local util = require("util")

local function find_cwd_files()
    local opts = {
        prompt_title = "~ FIND FILES ~",
        cwd = vim.fn.getcwd(),
        find_command = {
            "rg",
            "--follow",
            "--files",
            "--no-ignore",
            "--hidden",
            "--ignore-file",
            vim.env.HOME .. "/.rgignore",
            "--sort",
            "path",
        },
    }

    require("telescope.builtin").find_files(opts)
end

local function find_project_root_files()
    local opts = {
        prompt_title = "~ PROJECT FILES ~",
        cwd = util.find_dir_up({ ".git", "Makefile", "go.work", ".nvmrc", "go.mod", "package.json" }),
        find_command = {
            "rg",
            "--follow",
            "--files",
            "--no-ignore",
            "--hidden",
            "--ignore-file",
            vim.env.HOME .. "/.rgignore",
            "--sort",
            "path",
        },
    }

    require("telescope.builtin").find_files(opts)
end

return {
    --
    -- telescope default options
    --
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function(_, opts)
            local config = {
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
            }

            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, config)
        end,
        keys = {
            {
                "<C-p>",
                function()
                    find_cwd_files()
                end,
                desc = "Find files (cwd)",
            },
            {
                "<leader>ff",
                function()
                    find_cwd_files()
                end,
                desc = "Find files (cwd)",
            },
            {
                "<leader>fF",
                function()
                    find_project_root_files()
                end,
                desc = "Find files (project directory)",
            },
            {
                "<leader>fp",
                function()
                    find_project_root_files()
                end,
                desc = "Find files (project directory)",
            },
        },
    },

    --
    -- telescope file browser
    --
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        dependencies = {
            {
                "nvim-telescope/telescope-file-browser.nvim",
                config = function()
                    require("telescope").load_extension("file_browser") -- load this after fzf
                end,
            },
        },
        keys = {
            {
                "<leader>fw",
                "<cmd>Telescope file_browser path=%:p:h<CR>",
                remap = true,
                desc = "Telescope file browser",
            },
            {
                "<leader>fg",
                "<CMD>Telescope git_status<CR>",
                desc = "Telescope git status",
            },
        },
    },
}
