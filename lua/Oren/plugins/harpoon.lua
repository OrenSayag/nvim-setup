return {
    "thePrimeagen/harpoon",	
    enabled = true,
    branch = "harpoon2",
    -- Lazy load - only needed when using harpoon commands
    keys = {
        { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
        { "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup({
            global_settings = {
                save_on_toggle = true,
                save_on_change = true,
            },
        })
        -- Harpoon Nav Interface 
        -- Keymaps moved to keys table for lazy loading

        -- Harpoon marked files
        vim.keymap.set("n", "<C-y>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-i>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

    end
}
