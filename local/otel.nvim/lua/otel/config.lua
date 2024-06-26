local M = {}

-- layout = "{ctx}, {span} := {package}.{caller}().Start({ctx}, {name})",
-- var = {
--     ctx = "ctx",
--     span = "span",
-- },
local default_opts = {
    format_case = "", -- "" or snakecase
    delimiter = ".",
    template = {
        context_var = "ctx",
        span_var = "span",
        tracer_start_func = "opentelemetry.GetTracer().Start",
        trace_ctx_param_name = "ctx",
    },
}

local opts = default_opts

---@param options? table
function M.setup(options)
    opts = vim.tbl_deep_extend("force", default_opts, options or {})
end

function M.inspect()
    print("options:", vim.inspect(opts))
end

function M.get()
    return opts
end

return M
