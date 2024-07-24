return {
    {
        "stevearc/aerial.nvim",
        event = "LazyFile",
        keys = {
            {
                "<M-<>", -- alt/opt + <
                "<cmd>AerialPrev<cr>",
                silent = true,
                noremap = true,
                desc = "Aerial (Prev Symbol)",
            },
            {
                "<M->>", -- alt/opt + >
                "<cmd>AerialNext<cr>",
                silent = true,
                noremap = true,
                desc = "Aerial (Next Symbol)",
            },
        },
    },
}
