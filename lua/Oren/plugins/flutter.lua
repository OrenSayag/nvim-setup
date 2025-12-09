return {
	"nvim-flutter/flutter-tools.nvim",
	-- Lazy load - only needed for Flutter projects
	ft = { "dart" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local ok, flutter_tools = pcall(require, "flutter-tools")
		if not ok then
			return
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if has_cmp then
			capabilities = cmp_nvim_lsp.default_capabilities()
		end

		flutter_tools.setup({
			lsp = {
				-- Pass cmp capabilities so standard LSP completion works for Dart buffers.
				capabilities = capabilities,
				settings = {
					dart = {
						showTodos = true,
						completeFunctionCalls = true,
					},
				},
			},
		})
	end,
}
