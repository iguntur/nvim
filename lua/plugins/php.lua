return {
    --
    -- laravel blade treesitter
    --
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function(_, opts)
            vim.filetype.add({
                pattern = {
                    [".*%.blade%.php"] = "blade",
                },
            })

            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

            ---@diagnostic disable-next-line: inject-field
            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "blade",
            }

            return opts
        end,
    },

    --
    -- laravel blade nav (gf)
    --
    {
        "ricardoramirezr/blade-nav.nvim",
        dependencies = {
            "hrsh7th/nvim-cmp", -- if using nvim-cmp
        },
        ft = { "blade", "php" }, -- optional, improves startup time
    },
}
