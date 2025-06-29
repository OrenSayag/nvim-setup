return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	show_on_startup = true,
	config = function()
		vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
		require("nvim-tree").setup({})
	end,
}
