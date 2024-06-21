return {
    -- Lua
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- a function to call before loading the session
            -- pre_load = function()
            -- end,
            -- a function to call after loading the session
            -- post_load = function()
            -- end,
        },
    },
}
