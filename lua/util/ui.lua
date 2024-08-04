local M = {}

function M.statuscolumn()
    local parts = {
        diagnostics = "",
        fold = "%C",
        gitsigns = "",
        line_number = "%l",
        rel_line_number = "%r",
        align_right = "%=",
        signcolumn = "%s",
        space = " ",
        pipe = "│",
        T = "%T",
    }

    local p = parts

    local components = {
        ------------------------------------------------------------------------
        -- left
        ------------------------------------------------------------------------
        -- p.pipe,
        -- p.gitsigns,
        p.signcolumn,
        p.pipe,

        ------------------------------------------------------------------------
        -- middle
        ------------------------------------------------------------------------
        -- p.fold,
        p.diagnostics,
        -- p.signcolumn,
        p.rel_line_number, -- relative line number
        p.space,
        p.align_right,
        p.line_number, -- absolute line number
        p.space,

        ------------------------------------------------------------------------
        -- right
        ------------------------------------------------------------------------
        p.pipe,
        p.T,
    }

    return table.concat(components, "")
end

return M
