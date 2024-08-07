local util = require("util")
local LazyUtil = require("lazyvim.util")

local function find_cwd_files()
    local opts = {
        prompt_title = " Find Files (CWD)",
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

local function live_grep_cwd_files()
    local opts = {
        prompt_title = " Live Grep Files (CWD)",
        cwd = vim.fn.getcwd(),
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
            local actions = require("telescope.actions")
            local action_layout = require("telescope.actions.layout")

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
                    vertical = {
                        width = 0.9,
                        height = 0.9,
                    },
                    horizontal = {
                        width = 0.98,
                        height = 999,
                        preview_width = 0.6,
                    },
                    bottom_pane = {
                        preview_width = 0.6,
                        height = 999,
                    },
                },
                mappings = {
                    n = {
                        ["<M-p>"] = action_layout.toggle_preview,
                    },
                    i = {
                        ["<M-p>"] = action_layout.toggle_preview,
                    },
                },
            }

            --
            -- pickers
            --
            local pickersOptions = {
                buffers = {
                    mappings = {
                        -- delete/remove buffer from list
                        n = { ["<M-d>"] = actions.delete_buffer },
                        i = { ["<M-d>"] = actions.delete_buffer },
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
            opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, pickersOptions)
            opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, extensions)
        end,
        keys = {
            {
                "<leader>/",
                function()
                    live_grep_cwd_files()
                end,
                remap = true,
                silent = true,
                desc = "Telescope live grep (cwd)",
            },
            {
                "<leader>?",
                function()
                    live_grep_project()
                end,
                remap = true,
                silent = true,
                desc = "Telescope live grep (project directory)",
            },
            {
                "<C-p>",
                function()
                    find_cwd_files()
                end,
                desc = "Find files (cwd)",
            },
            {
                "<M-P>",
                function()
                    find_project_root_files()
                end,
                desc = "Find files (project directory)",
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
        -- "nvim-telescope/telescope.nvim",
        "neovim/nvim-lspconfig",
        -- optional = true,
        opts = function()
            if LazyVim.pick.want() ~= "telescope" then
                return
            end

            local lazy_keys = require("lazyvim.plugins.lsp.keymaps").get()

            local keys = {
                -- go to definition
                {
                    "gd",
                    function()
                        require("telescope.builtin").lsp_definitions({
                            reuse_win = true,
                            -- jump_type = "vsplit",
                        })
                    end,
                    silent = true,
                    remap = true,
                    desc = "[g]oto [d]efinition...",
                },

                -- go to implementation
                {
                    "gi",
                    function()
                        require("telescope.builtin").lsp_implementations({
                            reuse_win = true,
                            -- jump_type = "vsplit",
                        })
                    end,
                    desc = "[g]oto [i]mplementation",
                },
                {
                    "gI",
                    function()
                        require("telescope.builtin").lsp_implementations({
                            reuse_win = true,
                            -- jump_type = "vsplit",
                        })
                    end,
                    desc = "[g]oto [i]mplementation",
                },

                -- select git branch
                {
                    "<space>gb",
                    function()
                        require("telescope.builtin").git_branches({})
                    end,
                    desc = "Select [g]it [b]ranch",
                },
            }

            vim.list_extend(lazy_keys, keys)
        end,
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
                silent = true,
                noremap = true,
                desc = "Telescope [f]ile bro[w]ser",
            },
        },
    },
}
