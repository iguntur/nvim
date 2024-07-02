return {
    {
        "David-Kunz/gen.nvim",
        opts = {
            model = "codellama:7b",
            display_mode = "split",
        },
        keys = {
            {
                "<space>ai",
                ":Gen<CR>",
                mode = { "n", "v" },
                noremap = true,
                silent = true,
                desc = "Run ollama (AI)",
            },
        },
    },
}
