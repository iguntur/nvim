function D(args)
	print(vim.inspect(args))
	return args
end

function SafeRequire(moduleName, callback)
	local ok, m = pcall(require, moduleName)

	if ok then
		callback(m)
	end

	return ok, m
end
