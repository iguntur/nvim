return {
    --
    -- Auto-Focusing and Auto-Resizing Splits/Windows
    --
    {
        "nvim-focus/focus.nvim",
        version = "*",
        opts = {
            autoresize = {
                -- enable = true, -- Enable or disable auto-resizing of splits
                width = 140, -- Force width for the focused window
                -- height = 0, -- Force height for the focused window
                -- minwidth = 0, -- Force minimum width for the unfocused window
                -- minheight = 0, -- Force minimum height for the unfocused window
                -- height_quickfix = 10, -- Set the height of quickfix panel
            },
            ui = {
                -- number = false, -- Display line numbers in the focussed window only
                -- relativenumber = false, -- Display relative line numbers in the focussed window only
                -- hybridnumber = true, -- Display hybrid line numbers in the focussed window only
                -- absolutenumber_unfocussed = true, -- Preserve absolute numbers in the unfocussed windows

                -- cursorline = true, -- Display a cursorline in the focussed window only
                -- cursorcolumn = true, -- Display cursorcolumn in the focussed window only
                -- colorcolumn = {
                --     enable = false, -- Display colorcolumn in the foccused window only
                --     list = "+1", -- Set the comma-saperated list for the colorcolumn
                -- },
                -- signcolumn = true, -- Display signcolumn in the focussed window only
                -- winhighlight = true, -- Auto highlighting for focussed/unfocussed windows
            },
        },
    },
}
