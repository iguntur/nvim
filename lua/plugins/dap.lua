local M = {}

local default_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local function kmap(mode, lhs, rhs, options)
	options = options or default_opts
	keymap(mode, lhs, rhs, options)
end

local function setup_dap()
	local ok, dap = pcall(require, "dap")

	if not ok then
		return
	end

	dap.adapters.go = function(callback, config)
		local stdout = vim.loop.new_pipe(false)
		local handle
		local pid_or_err
		local port = 38697
		local opts = {
			stdio = { nil, stdout },
			args = { "dap", "-l", "127.0.0.1:" .. port },
			detached = true,
		}
		handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
			stdout:close()
			handle:close()
			if code ~= 0 then
				print("dlv exited with code", code)
			end
		end)
		assert(handle, "Error running dlv: " .. tostring(pid_or_err))
		stdout:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				vim.schedule(function()
					require("dap.repl").append(chunk)
				end)
			end
		end)
		-- Wait for delve to start
		vim.defer_fn(function()
			callback({ type = "server", host = "127.0.0.1", port = port })
		end, 100)
	end

	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			program = "${file}",
		},
		{
			type = "go",
			name = "Debug test", -- configuration for debugging test files
			request = "launch",
			mode = "test",
			program = "${file}",
		},
		-- works with go.mod packages and sub packages
		{
			type = "go",
			name = "Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}",
		},
	}
end

local function setup_dap_keymaps()
	kmap("n", "<space>dd", "<cmd>DapToggleBreakpoint<CR>")
	kmap("n", "<F5>", "<cmd>DapContinue<CR>")
	kmap("n", "<F6>", "<cmd>DapStepInto<CR>")
	kmap("n", "<F7>", "<cmd>DapStepOut<CR>")
	kmap("n", "<F8>", "<cmd>DapStepOver<CR>")
	kmap("n", "<F9>", "<cmd>DapTerminate<CR>")
end

local function setup_dap_go()
	local ok, dapgo = pcall(require, "dap-go")

	if not ok then
		return
	end

	dapgo.setup()

	kmap("n", "<Leader>td", "<cmd>lua require('dap-go').debug_test()<CR>")
end

M.setup = function(use)
	use("mfussenegger/nvim-dap")
	use("leoluz/nvim-dap-go")

	setup_dap()
	setup_dap_keymaps()
	setup_dap_go()
end

return M
