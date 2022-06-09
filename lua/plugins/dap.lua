local safe_require = require("utils").safe_require

local M = {}

local default_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local function kmap(mode, lhs, rhs, options)
	options = options or default_opts
	keymap(mode, lhs, rhs, options)
end

local function setup_dapui(dap)
	local event_name = "dapui_config"

	safe_require("dapui", function(dapui)
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
	end)
end

local function setup_golang_dap(dap)
	safe_require("dap-go", function(dapgo)
		dapgo.setup()
	end)

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

local function setup_dap()
	safe_require("dap", function(dap)
		setup_dapui(dap)
		setup_golang_dap(dap)
	end)

	safe_require("nvim-dap-virtual-text", function(dapVT)
		dapVT.setup()
	end)
end

local function setup_dap_keymaps()
	-- General dap keymaps
	kmap("n", "<F1>", "<cmd>lua require('dap').step_over()<CR>")
	kmap("n", "<F2>", "<cmd>lua require('dap').step_into()<CR>")
	kmap("n", "<F3>", "<cmd>lua require('dap').step_out()<CR>")
	kmap("n", "<F4>", "<cmd>lua require('dap').continue()<CR>")
	kmap("n", "<F11>", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
	kmap("n", "<F12>", "<cmd>lua require('dap').terminate()<CR>")

	-- Go keymaps
	kmap("n", "<Leader>td", "<cmd>lua require('dap-go').debug_test()<CR>")
end

M.setup = function(use)
	use("mfussenegger/nvim-dap") -- the adapter protocol
	use("theHamsta/nvim-dap-virtual-text") -- dap virtual text
	use("leoluz/nvim-dap-go") -- the golang language adapter
	use({ -- dap ui
		"rcarriga/nvim-dap-ui",
		requires = {
			"mfussenegger/nvim-dap",
		},
	})

	setup_dap()
	setup_dap_keymaps()
end

return M
