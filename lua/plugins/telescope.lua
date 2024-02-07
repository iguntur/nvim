local util = require("util")
local LazyUtil = require("lazyvim.util")

local function find_cwd_files()
    local opts = {
        prompt_title = " Find Files",
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
        prompt_title = " Project Files",
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

local function live_grep_project()
    local opts = {
        prompt_title = " Live Grep Project Files",
        cwd = util.find_dir_up({ ".git", "Makefile", "go.work", ".nvmrc", "go.mod", "package.json" }),
        vimgrep_arguments = {
            "rg",
            "--follow",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--ignore-file",
            vim.env.HOME .. "/.rgignore",
            "--glob",
            "!**/.git/*",
        },
    }

    require("telescope.builtin").live_grep(opts)
end

local function open_journals_files()
    local opts = {
        prompt_title = "󱨋 Journals",
        cwd = vim.env.HOME .. "/journals",
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
            local telescopeConfig = require("telescope.config")

            -- Clone the default Telescope configuration
            local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
            local argvs = {
                "--follow",
                "--hidden",
                "--ignore-file",
                vim.env.HOME .. "/.rgignore",
                "--glob",
                "!**/.git/*",
                -- "-u", -- alias for --unrestricted
                -- "--trim" -- add this value
            }

            for _, argv in ipairs(argvs) do
                table.insert(vimgrep_arguments, argv)
            end

            --
            -- default config
            --
            local defaults = {
                -- path_display = { "smart" }, -- smart,truncate,shorten. default: truncate
                vimgrep_arguments = vimgrep_arguments,
                -- layout_strategy = "bottom_pane", -- vertical, horizontal, flex, bottom_pane
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                    horizontal = {
                        width = 500,
                        height = 500,
                    },
                    bottom_pane = {
                        height = 100,
                    },
                },
            }

            --
            -- extensions
            --
            local extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
            }

            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, defaults)
            opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, extensions)
        end,
        keys = {
            {
                "<leader>/",
                function()
                    live_grep_project()
                end,
                remap = true,
                silent = true,
                desc = "Telescope live grep",
            },
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
            {
                "<leader>fg",
                "<CMD>Telescope git_status<CR>",
                desc = "Telescope git status",
            },
            {
                "<leader>fj",
                function()
                    open_journals_files()
                end,
                desc = "Search Journal",
            },
        },
    },

    --
    -- telescopt with LSP
    --
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        keys = {
            {
                "gi",
                function()
                    require("telescope.builtin").lsp_implementations({ reuse_win = true })
                end,
                desc = "Go To Implementation",
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
                    LazyUtil.on_load("telescope.nvim", function()
                        require("telescope").load_extension("file_browser") -- load this after fzf
                    end)
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
        },
    },
}
