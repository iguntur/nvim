local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local workspaces = {
    -- Format: <name_of_workspace> = <path_to_workspace_root>
    personal = "~/dev/notes/guntur",
    efishery = "~/dev/notes/efishery",
    ruangguru = "~/dev/notes/ruangguru",
}

local function select_neorg_workspace()
    -- basic telescope configuration
    local conf = require("telescope.config").values
    local workspace_names = {}

    for name, _ in pairs(workspaces) do
        table.insert(workspace_names, name)
    end

    local function run_selection(prompt_bufnr)
        actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()

            vim.cmd([[silent! Neorg workspace ]] .. selection[1])
        end)

        return true
    end

    local opts = {
        layout_strategy = "vertical", -- vertical, horizontal, flex, bottom_pane
        sorting_strategy = "ascending",
        layout_config = {
            prompt_position = "top",
            vertical = {
                width = 0.5,
                height = 0.5,
            },
        },
    }

    require("telescope.pickers")
        .new(opts, {
            prompt_title = " Select Neorg Workspaces",
            finder = require("telescope.finders").new_table({
                results = workspace_names,
            }),
            previewer = false,
            -- previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
            attach_mappings = run_selection,
        })
        :find()
end

return {
    --
    -- luarocks
    --
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },

    --
    -- neorg
    --
    {
        "nvim-neorg/neorg",
        dependencies = {
            "luarocks.nvim",
        },
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        build = ":Neorg sync-parsers",
        config = function()
            local neorg = require("neorg")

            neorg.setup({
                load = {
                    -- Loads default behaviour
                    ["core.defaults"] = {},
                    ["core.keybinds"] = {
                        config = {
                            default_keybinds = true,
                        },
                    },

                    -- journals

                    -- dirman
                    ["core.dirman"] = {
                        config = {
                            workspaces = workspaces,
                            default_workspace = "personal",
                            index = "index.norg", -- The name of the main (root) .norg file
                        },
                    },

                    -- Adds pretty icons to your documents
                    ["core.concealer"] = {
                        config = {
                            icons = {
                                code_block = {
                                    conceal = true,
                                },
                            },
                        },
                    },

                    -- ["external.kanban"] = {},
                    -- ["core.ui.calendar"] = {},
                },
            })
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        keys = {
            {
                "<leader>nw",
                select_neorg_workspace,
                silent = true,
                noremap = true,
                desc = "Select neorg workspaces",
            },
            {
                "<leader>nf",
                function()
                    require("telescope.builtin").find_files({
                        prompt_title = "󰗚 Find Workspace Files",
                        cwd = "~/dev/notes",
                    })
                end,
                silent = true,
                noremap = true,
                desc = "Select neorg files",
            },
            {
                "<leader>nr",
                "<cmd>Neorg return<cr>",
                silent = true,
                noremap = true,
                desc = "Neorg return",
            },
        },
    },
}
