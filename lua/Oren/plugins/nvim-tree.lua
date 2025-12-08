return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = true, -- Lazy load to improve startup time
	cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
		require("nvim-tree").setup({})
	end,
}
