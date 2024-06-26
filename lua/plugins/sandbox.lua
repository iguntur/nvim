local function plugin_dir(name)
    return vim.fn.stdpath("config") .. "/local/" .. name .. ".nvim"
end

return {
    {
        "otel",
        dir = plugin_dir("otel"),
        -- dev = true,
        config = function()
            local otel = require("otel")

            otel.setup()

            vim.keymap.set("n", "<space>d", function()
                otel.go_trace()
            end, { silent = true, noremap = true, desc = "Add otel tracer span" })
        end,
    },
}
