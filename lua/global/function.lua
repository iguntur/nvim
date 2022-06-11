function D(args)
	print(vim.inspect(args))
	return args
end

function SafeRequire(moduleName, callback)
	local ok, m = pcall(require, moduleName)

	if not ok then
		return
	end

	callback(m)
end
