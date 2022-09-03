local M = {}

local default_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local isDisable = true

local function kmap(mode, lhs, rhs, options)
	options = options or default_opts
	keymap(mode, lhs, rhs, options)
end

local function dapui_setup(dap, dapui)
	local event_name = "dapui_config"

	dapui.setup()

	dap.listeners.after.event_initialized[event_name] = function()
		dapui.open()
	end

	dap.listeners.before.event_terminated[event_name] = function()
		dapui.close()
	end

	dap.listeners.before.event_exited[event_name] = function()
		dapui.close()
	end

	SafeRequire("nvim-dap-virtual-text", function(dapVT)
		dapVT.setup()
	end)
end

local function dap_go_setup(dap)
	SafeRequire("dap-go", function(dapgo)
		dapgo.setup()
	end)

	-- if isDisable then
	-- 	return
	-- end

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
		end, 1000)
	end

	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "go",
			name = "[launch] Debug main file",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = "${workspaceFolder}/main.go",
		},
		{
			type = "go",
			name = "[launch] Debug current file",
			request = "launch",
			program = "${file}",
		},
		{
			type = "go",
			name = "[launch] Debug test", -- configuration for debugging test files
			request = "launch",
			mode = "test",
			program = "${file}",
		},

		-- works with go.mod packages and sub packages
		{
			type = "go",
			name = "[launch] Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}",
		},
	}
end

local function setup_dap_keymaps()
	-- kmap("n", "<Leader>dd", "<cmd>GoBreakToggle<CR>")
	-- kmap("n", "<Leader>dg", "<cmd>GoDebug<CR>")
	-- kmap("n", "<Leader>dx", "<cmd>GoDbgStop<CR>")

	-- if isDisable then
	-- 	return
	-- end

	-- General dap keymaps
	kmap("n", "<F4>", "<cmd>lua require('dapui').toggle()<CR>")

	kmap("n", "<F1>", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
	kmap("n", "<F2>", "<cmd>lua require('dap').step_out()<CR>")
	kmap("n", "<F3>", "<cmd>lua require('dap').step_into()<CR>")

	kmap("n", "<F9>", "<cmd>lua require('dap').terminate()<CR>")
	kmap("n", "<F11>", "<cmd>lua require('dap').step_over()<CR>")
	kmap("n", "<F12>", "<cmd>lua require('dap').continue()<CR>")

	kmap("n", "<space>ds", "<cmd>lua require('dap').step_over()<CR>")
	kmap("n", "<space>di", "<cmd>lua require('dap').step_into()<CR>")
	kmap("n", "<space>do", "<cmd>lua require('dap').step_out()<CR>")
	kmap("n", "<space>dc", "<cmd>lua require('dap').continue()<CR>")
	kmap("n", "<space>dd", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
	kmap("n", "<space>dx", "<cmd>lua require('dap').terminate()<CR>")

	-- Go keymaps
	kmap("n", "<Leader>td", "<cmd>lua require('dap-go').debug_test()<CR>")
end

M.setup = function(use)
	use({ "mfussenegger/nvim-dap" }) -- the adapter protocol
	use({ "rcarriga/nvim-dap-ui" }) -- dap ui
	use({ "theHamsta/nvim-dap-virtual-text" }) -- dap virtual text
	use({ "leoluz/nvim-dap-go" }) -- the golang language adapter

	SafeRequire("dap", function(dap)
		SafeRequire("dapui", function(dapui)
			dapui_setup(dap, dapui)

			dap_go_setup(dap)
		end)
	end)

	setup_dap_keymaps()
end

return M
