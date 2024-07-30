local function augroup(name)
    return vim.api.nvim_create_augroup("the_guntur_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = augroup("nopaste"),
    pattern = { "*" },
    command = "set nopaste",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("conceal"),
    pattern = { "json", "jsonc", "markdown" },
    callback = function()
        vim.wo.conceallevel = 0 -- normal -- normal
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("spell"),
    pattern = { "json", "jsonc", "markdown" },
    callback = function()
        vim.wo.spell = false
    end,
})

-- Focus window
local ignore_filetypes = {
    "neo-tree",
    "NvimTree",
    "Outline",
    "aerial",
    "dbui",
}
local ignore_buftypes = {
    "nofile",
    "prompt",
    "popup",
}

local focus_group = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
    group = focus_group,
    callback = function(_)
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
            vim.w.focus_disable = true
        else
            vim.w.focus_disable = false
        end
    end,
    desc = "Disable focus autoresize for BufType",
})

vim.api.nvim_create_autocmd("FileType", {
    group = focus_group,
    callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
        else
            vim.b.focus_disable = false
        end
    end,
    desc = "Disable focus autoresize for FileType",
})

-- always centered screen
-- when jumping using lsp go to definition
-- then force screen always centered event cursor target on the bottom
local centered_group = vim.api.nvim_create_augroup("CenteredGroup", { clear = true })
local centered_options = {
    group = centered_group,
    callback = function()
        vim.cmd("normal! zz")
    end,
}

vim.api.nvim_create_autocmd("BufEnter", centered_options)
vim.api.nvim_create_autocmd("CursorMoved", centered_options)
