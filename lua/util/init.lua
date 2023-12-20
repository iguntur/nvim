local M = {}

function M.d(args)
    print(vim.inspect(args))
    return args
end

function M.SafeRequire(moduleName, callback)
    local ok, m = pcall(require, moduleName)

    if not ok then
        vim.notify("Module " .. moduleName .. " is not installed yet")
        return
    end

    callback(m)
end

function M.find_dir_up(...)
    local patterns = vim.tbl_flatten({ ... })
    local current_dir = vim.fn.getcwd()

    for _, pattern in ipairs(patterns) do
        while current_dir ~= "/" do
            local fp = current_dir .. "/" .. pattern

            if vim.fn.isdirectory(fp) == 1 or vim.fn.filereadable(fp) == 1 then
                return current_dir
            end

            current_dir = vim.fn.fnamemodify(current_dir, ":h")
        end
    end

    return vim.fn.getcwd()
end

return M
