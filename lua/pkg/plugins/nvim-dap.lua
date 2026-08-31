return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui"
	},
	config = function()
		local dap = require("dap")
		local mason_bin = "~/.local/share/nvim/mason/bin/"
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = mason_bin .. "codelldb",
				args = { "--port", "${port}" }
			},
		}

		dap.adapters.python = function(cb, config)
			if config.request == 'attach' then
				local port = (config.connect or config).port
				local host = (config.connect or config).host or '127.0.0.1'
				cb({
					type = 'server',
					port = assert(port, 'Port not provided'),
					host = host,
					options = { source_filetype = 'python' },
				})
			else
				cb({
					type = 'executable',
					command = os.getenv('VIRTUAL_ENV') .. '/bin/python',
					args = { '-m', 'debugpy.adapter' },
					options = {
						source_filetype = 'python',
					},
				})
			end
		end

		dap.configurations.cpp = { {
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
		} }

		dap.configurations.objcpp = { {
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
		} }

		dap.configurations.python = { {
			name = "Launch file",
			type = 'python',
			request = 'launch',
			program = "${file}",
			pythonPath = function()
				if not os.getenv('VIRTUAL_ENV') then
					return ''
				else
					return os.getenv('VIRTUAL_ENV') .. '/bin/python'
				end
			end
		} }

		local dapui = require("dapui")
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end

		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end
}
