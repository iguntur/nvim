--
-- My Local Development Plugin(s)
--
local path = vim.fn.expand("$HOME/.config/nvim/dev")

return {
    {
        "otel_tracing",
        -- opts = {},
        dev = {
            path = path,
        },
        keys = {
            {
                "<space>d",
                ":luafile ~/.config/nvim/dev/otel_tracing/lua/init.lua<CR>",
                silent = true,
                noremap = true,
            },
        },
    },
}
