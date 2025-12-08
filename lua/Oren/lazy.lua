local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        { import = "Oren.plugins" },
        { import = "Oren.plugins.lsp" },
    },
    {
        checker = {
            enabled = false, -- Disable checker during startup for faster load
            notify = false,
            -- Check for updates less frequently to reduce overhead
            frequency = 86400, -- Check once per day instead of default
        },
        change_detection = {
            notify = false,
            -- Disable change detection during startup for faster load
            enabled = false, -- Can be enabled manually if needed
        },
        -- Performance optimizations
        performance = {
            rtp = {
                -- Disable some rtp plugins that are not needed
                disabled_plugins = {
                    "gzip",
                    "matchit",
                    "matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                },
            },
        },
    }
)
