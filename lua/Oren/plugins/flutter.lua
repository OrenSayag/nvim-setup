return {
	"nvim-flutter/flutter-tools.nvim",
	-- Lazy load - only needed for Flutter projects
	ft = { "dart" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	config = true,
}
