return {
	"rmagatti/auto-session",
	-- Lazy load - session management, loads when needed
	cmd = { "SessionSave", "SessionRestore", "SessionDelete" },
	keys = {
		{ "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore Session for cwd" },
		{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for auto session root dir" },
	},
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
		})

		-- Keymaps moved to keys table for lazy loading
	end,
}
