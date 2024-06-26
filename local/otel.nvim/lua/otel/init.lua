local config = require("otel.config")
local go = require("otel.ft_go")

local M = {}

function M.print_options()
    config.inspect()
end

function M.setup(options)
    config.setup(options)
end

function M.go_trace()
    go.fire()
end

return M
