local ts = vim.treesitter

local M = {}

local query_str = [[
(method_declaration
	receiver: (parameter_list
		(parameter_declaration
			(pointer_type
				(type_identifier) @ti
			)
		)
	)
	name: (field_identifier) @fi
	body: (block) @bb
)
]]

local lang = "go" -- parser:lang()

local default = {
    format_case = "", -- "" or snakecase
    delimiter = ".",
    template = {
        context_var = "ctx",
        span_var = "span",
        tracer_start_func = "opentelemetry.GetTracer().Start",
        trace_ctx_param_name = "ctx",
    },
}

local function starts_with(str, start)
    return str:sub(1, #start) == start
end

local function str_snake_case(s)
    s = s:gsub("%u", function(c)
        return "_" .. c:lower()
    end)

    if starts_with(s, "_") then
        return s:sub(2)
    end

    return s
end

---@param opts? table
local function traceme(opts)
    opts = vim.tbl_extend("force", default, opts or {})
    local t = opts.template

    local current_node = ts.get_node()
    local node_type = current_node:type()

    if node_type ~= "field_identifier" then
        return
    end

    local parent_node_text = ts.get_node_text(current_node:parent(), 0)
    if not starts_with(parent_node_text, "func") then
        return
    end

    local parsed = ts.query.parse(lang, query_str)
    local span_texts = {}
    local start_body_line_number = nil

    for _, nd, _ in parsed:iter_captures(current_node:parent(), 0) do
        if nd:type() == "type_identifier" or nd:type() == "field_identifier" then
            local nt = ts.get_node_text(nd, 0)

            if opts.format_case == "snakecase" then
                nt = str_snake_case(nt)
            end

            table.insert(span_texts, nt)
        end

        if nd:type() == "block" then
            start_body_line_number = nd:start()
        end
    end

    if start_body_line_number == nil then
        return
    end

    local span_text_name = table.concat(span_texts, opts.delimiter)
    local text_1 = string.format(
        '\t%s, %s := %s(%s, "%s")',
        t.context_var,
        t.span_var,
        t.tracer_start_func,
        t.trace_ctx_param_name,
        span_text_name
    )
    local text_2 = string.format("\tdefer %s.End()", t.span_var)
    local output_texts = { text_1, text_2 }

    local line_number = start_body_line_number + 1
    local existing_line_text = vim.api.nvim_buf_get_lines(0, line_number, line_number + 1, false)[1]

    if existing_line_text ~= nil and existing_line_text ~= "" then
        table.insert(output_texts, "")
        table.insert(output_texts, existing_line_text)
    end

    vim.api.nvim_buf_set_lines(0, line_number, line_number + 1, false, output_texts)
end

function M.setup(opts)
    traceme(opts)
end

M.setup({
    format_case = "snakecase",
})

return M
