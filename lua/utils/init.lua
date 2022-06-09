local M = {}

M.safe_require = function(moduleName, callback)
	local ok, m = pcall(require, moduleName)

	if not ok then
		return
	end

	callback(m)
end

return M
