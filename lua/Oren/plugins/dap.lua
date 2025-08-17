local function setupListeners()
	local dap = require("dap")
	local areSet = false

	vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue", noremap = true })

	dap.listeners.after["event_initialized"]["me"] = function()
		if not areSet then
			areSet = true
			vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run To Cursor" })
			vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
			vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "Hover" })
			vim.keymap.set({ "n", "v" }, "<Leader>de", require("dapui").eval, { desc = "Eval" })
		end
	end

	dap.listeners.after["event_terminated"]["me"] = function()
		if areSet then
			areSet = false
			vim.keymap.del("n", "<leader>dc")
			vim.keymap.del("n", "<leader>dC")
			vim.keymap.del("n", "<leader>ds")
			vim.keymap.del("n", "<leader>di")
			vim.keymap.del("n", "<leader>do")
			vim.keymap.del({ "n", "v" }, "<Leader>dh")
			vim.keymap.del({ "n", "v" }, "<Leader>de")
		end
	end
end

local function setupPhp()
	local dap = require("dap")
	dap.adapters.php = {
		type = "executable",
		command = "node",
		args = { os.getenv("HOME") .. "/tools/vscode-php-debug/out/phpDebug.js" },
	}

	dap.configurations.php = {
		{
			type = "php",
			request = "launch",
			name = "Listen for Xdebug",
			port = 9003,
			pathMappings = {
				["/app"] = "${workspaceRoot}",
			},
		},
	}
end

local function setupJs()
	local dap = require("dap")
	dap.adapters.chrome = {
		type = "executable",
		command = "node",
		args = { os.getenv("HOME") .. "/tools/vscode-chrome-debug/out/src/chromeDebug.js" },
	}

	dap.configurations.javascriptreact = { -- change this to javascript if needed
		{
			type = "chrome",
			request = "attach",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			port = 9222,
			webRoot = "${workspaceFolder}",
		},
	}

	dap.configurations.typescriptreact = { -- change to typescript if needed
		{
			type = "chrome",
			request = "attach",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			port = 9222,
			webRoot = "${workspaceFolder}",
		},
	}

	dap.adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "node",
			-- 💀 Make sure to update this path to point to your installation
			args = { os.getenv("HOME") .. "/tools/js-debug/src/dapDebugServer.js", "${port}" },
		},
	}

	dap.configurations.javascript = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
	}
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"wojciech-kulik/xcodebuild.nvim",
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
	},
	config = function()
		local xcodebuild = require("xcodebuild.integrations.dap")

		-- TODO: make sure to set path to your codelldb
		local codelldbPath = os.getenv("HOME") .. "/tools/codelldb-aarch64-darwin/extension/adapter/codelldb"
		xcodebuild.setup(codelldbPath)

		local define = vim.fn.sign_define
		define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
		define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
		define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

		setupListeners()
		setupJs()
		setupPhp()

		--when breakpoint is hit, it sets the focus to the buffer with the breakpoint
		require("dap").defaults.fallback.switchbuf = "usetab,uselast"

    --stylua: ignore start
    vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
    vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
    vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
    vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
    vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
		--stylua: ignore end

		vim.keymap.set("n", "<leader>dx", function()
			xcodebuild.terminate_session()
			require("dap").listeners.after["event_terminated"]["me"]()
		end, { desc = "Terminate debugger" })
	end,
}
