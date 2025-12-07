return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },

				-- ensure these languages parsers are installed
				ensure_installed = {
					"go",
					"dart",
					"lua", -- needed for Neovim config
					"json",
					"yaml",
					"markdown",
					"markdown_inline",
					"bash",
					"vim",
					"vimdoc",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-a>",
						node_incremental = "<C-a>",
						scope_incremental = false,
					},
				},
				additional_vim_regex_highlighting = false,
			})
		end,
	},
}
