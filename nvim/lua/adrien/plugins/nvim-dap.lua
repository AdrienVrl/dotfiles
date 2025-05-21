return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		require("dapui").setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		dap.adapters.cpp = {
			type = "executable",
			attach = {
				pidProperty = "pid",
				pidSelect = "ask",
			},
			command = "lldb-dap", -- my binary was called 'lldb-vscode-11'
			env = {
				LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
			},
			name = "lldb",
		}

		dap.configurations.cpp = {
			{
				name = "lldb",
				type = "cpp",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				externalTerminal = false,
				stopOnEntry = false,
				args = {},
			},
		}
		vim.keymap.set("n", "<Leader>bp", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>bc", dap.continue, {})
	end,
}
