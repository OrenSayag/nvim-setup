return {
    "mbbill/undotree",
    -- Lazy load - only needed when toggling undotree
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
    },
    config = function()
        -- Configuration can be added here if needed
    end,
}
