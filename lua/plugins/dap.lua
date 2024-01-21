local actions_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local util = require("util")

local function find_package_main_files(cb)
    local cwd = util.find_dir_up({ "go.mod", "go.sum", ".git", "Makefile", "go.work" })
    local opts = {
        prompt_title = " select the main program - (" .. cwd .. ")",
        cwd = cwd,
        find_command = { "rg", "--follow", "--no-ignore", "--files-with-matches", "package main" },
        layout_strategy = "vertical", -- vertical, horizontal, flex, bottom_pane
        sorting_strategy = "ascending",
        layout_config = {
            prompt_position = "top",
            vertical = {
                width = 0.5,
                height = 0.5,
            },
        },
        attach_mappings = function(_, map)
            map({ "n", "i" }, "<cr>", function(prompt_bufnr)
                actions.close(prompt_bufnr)
                local entries = actions_state.get_selected_entry()
                local main_file = entries[1]
                cb(main_file)
            end)

            return true
        end,
    }

    require("telescope.builtin").find_files(opts)
end

local function get_package_main_filepath()
    return coroutine.create(function(dap_run_cmd)
        find_package_main_files(function(main_file)
            coroutine.resume(dap_run_cmd, main_file)
        end)
    end)
end

return {
    {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
            require("persistent-breakpoints").setup({
                load_breakpoints_event = { "BufReadPost" },
            })

            vim.keymap.set("n", "<leader>db", function()
                require("persistent-breakpoints.api").toggle_breakpoint()
            end, { silent = true, remap = true, desc = "Toggle breakpoint!" })

            vim.keymap.set("n", "<leader>dB", function()
                require("persistent-breakpoints.api").set_conditional_breakpoint()
            end, { silent = true, remap = true, desc = "Breakpoint condition!" })

            vim.keymap.set("n", "<leader>dX", function()
                require("persistent-breakpoints.api").clear_all_breakpoints()
            end, { silent = true, noremap = true, desc = "Clear all debug breakpoints" })
        end,
    },

    --
    -- dap
    --
    {
        "mfussenegger/nvim-dap",
    },

    --
    -- dap go
    --
    {
        "leoluz/nvim-dap-go",
        dependencies = {
            { "mfussenegger/nvim-dap" },
        },
        config = function()
            require("dap-go").setup()

            local dap = require("dap")

            dap.set_log_level("TRACE")

            --
            -- setup dap adapters
            --
            local port = 38690
            dap.adapters.go = {
                type = "server",

                -- a string that defines the port to start delve debugger.
                -- default to string "${port}" which instructs nvim-dap
                -- to start the process in a random available port
                -- port = 38697,
                -- port = port,
                port = "${port}",

                executable = {
                    -- the path to the executable dlv which will be used for debugging.
                    -- by default, this is the "dlv" executable on your PATH.
                    command = vim.fn.expand("$GOBIN/dlv"),
                    -- command = vim.fn.stdpath("data") .. "/mason/bin/dlv",

                    -- additional args to pass to dlv
                    -- args = { "dap", "-l", "0.0.0.0:" .. port },
                    args = { "dap", "-l", "0.0.0.0:${port}" },
                },
                options = {
                    initialize_timeout_sec = 20,
                },
            }

            --
            -- setup dap go
            --
            local go_configs = {
                {
                    type = "go",
                    name = "[1] Launch: run program from the main.go and debug",
                    request = "launch",
                    program = "${workspaceFolder}",
                    -- buildFlags = "",
                },
                {
                    type = "go",
                    name = "[2] Launch: search the main.go and debug",
                    request = "launch",
                    program = get_package_main_filepath,
                    -- buildFlags = "",
                },

                --
                -- TODO: debug launch or attach using remote mode
                --
                {
                    type = "go",
                    name = "Remote: launch",
                    mode = "remote",
                    request = "launch",
                    host = "0.0.0.0",
                    port = port,
                    remotePath = "/app",
                    program = "${workspaceFolder}/main.go",
                },
                {
                    type = "go",
                    name = "Remote: attach",
                    mode = "remote",
                    request = "attach",
                    subtitutePath = {
                        {
                            from = "${workspaceFolder}",
                            to = "/app",
                        },
                    },
                    -- buildFlags = "-buildvcs=false",
                },
            }

            for _, config in ipairs(go_configs) do
                table.insert(dap.configurations.go, config)
            end
        end,
    },
}
