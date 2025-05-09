local dap = require('dap')
require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")

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

dap.adapters.node2 = {
	type = 'executable',
	command = 'node',
	args = { os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
	{
		name = 'Launch file',
		type = 'node2',
		request = 'launch',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		console = 'integratedTerminal',
	},
}

dap.configurations.typescript = {
	{
		name = 'Launch TypeScript',
		type = 'node2',
		request = 'launch',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		console = 'integratedTerminal',
		outFiles = { "${workspaceFolder}/dist/**/*.js" },
	},
}

dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
		args = { "--port", "${port}" },
	}
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	},
}
dap.adapters.php = {
	type = 'executable',
	command = 'node',
	args = {
		vim.fn.stdpath("data") .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js'
	}
}

dap.configurations.php = {
	{
		type = 'php',
		request = 'launch',
		name = 'Listen for Xdebug',
		port = 9003,
		pathMappings = {
			["/var/www/"] = "${workspaceFolder}", -- adjust this as needed
		},
	},
}
dap.adapters.coreclr = {
	type = 'executable',
	command = vim.fn.stdpath("data") .. '/mason/packages/netcoredbg/netcoredbg',
	args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Launch - .NET Core",
		request = "launch",
		program = function()
			return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
		end,
	},
}
dap.adapters.go = {
	type = 'server',
	port = 38697,
	executable = {
		command = 'dlv',
		args = { 'dap', '-l', '127.0.0.1:38697' },
	}
}

dap.configurations.go = {
	{
		type = 'go',
		name = 'Debug',
		request = 'launch',
		program = "${file}",
	},
}
