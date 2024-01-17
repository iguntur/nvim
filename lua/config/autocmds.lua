vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = { "*" },
    command = "set nopaste",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "json",
        "jsonc",
        "markdown",
    },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0 -- normal -- normal
    end,
})
