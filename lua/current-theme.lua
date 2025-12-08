-- Load tokyonight colorscheme efficiently
-- Defer to ensure plugin is loaded
vim.defer_fn(function()
	vim.cmd("colorscheme tokyonight-storm")
end, 0)