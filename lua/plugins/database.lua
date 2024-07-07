local sql_ft = { "sql", "mysql", "plsql" }

local function find_query_files()
    local data_path = vim.fn.expand("$HOME/.local/share/dadbod_ui")

    local opts = {
        prompt_title = "󱤟 Find Query",
        cwd = data_path,
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
    -- dadbod core
    --
    {
        "tpope/vim-dadbod",
    },

    --
    -- dadbod UI
    --
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            {
                "tpope/vim-dadbod",
                lazy = true,
                cmd = { "DB" },
            },
        },
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        init = function()
            local data_path = vim.fn.expand("$HOME/.local/share/dadbod_ui")

            vim.g.db_ui_save_location = data_path
            vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"

            vim.g.db_ui_auto_execute_table_helpers = 1
            vim.g.db_ui_show_database_icon = true
            vim.g.db_ui_use_nerd_fonts = true
            vim.g.db_ui_use_nvim_notify = false

            -- NOTE: The default behavior of auto-execution of queries on save is disabled
            -- this is useful when you have a big query that you don't want to run every time
            -- you save the file running those queries can crash neovim to run use the
            -- default keymap: <leader>S
            vim.g.db_ui_execute_on_save = false
        end,
    },

    {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = "vim-dadbod",
        ft = sql_ft,
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = sql_ft,
                callback = function()
                    local cmp = require("cmp")

                    -- global sources
                    ---@param source cmp.SourceConfig
                    local sources = vim.tbl_map(function(source)
                        return {
                            name = source.name,
                        }
                    end, cmp.get_config().sources)

                    -- add vim-dadbod-completion source
                    table.insert(sources, { name = "vim-dadbod-completion" })
                    table.insert(sources, { name = "buffer" })

                    -- update sources for the current buffer
                    cmp.setup.buffer({ sources = sources })
                end,
            })
        end,
    },

    {
        "mfussenegger/nvim-lint",
        enabled = false,
        opts = function(_, opts)
            for _, ft in ipairs(sql_ft) do
                opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
                table.insert(opts.linters_by_ft[ft], "sqlfluff")
            end
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        keys = {
            {
                "<leader>fq",
                find_query_files,
                silent = true,
                noremap = true,
                desc = "[F]ind [q]uery files",
            },
        },
    },
}
