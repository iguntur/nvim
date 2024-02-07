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
