return {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    {
        "NvChad/nvim-colorizer.lua",
        dependencies = { "nvim-treesitter/nvim-treesitter"},
        opts = {},
        config = function()
            local nvchadcolorizer = require("colorizer")
            local tailwindcolorizer = require("tailwindcss-colorizer-cmp")

            nvchadcolorizer.setup({
                user_default_options = {
                    tailwind = true,
                },
                filetypes = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
            })
            tailwindcolorizer.setup({
                color_square_width = 2,
            })
            -- Only attach colorizer to relevant filetypes to avoid unnecessary processing
            vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
                callback = function()
                    local ft = vim.bo.filetype
                    local relevant_fts = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" }
                    for _, relevant_ft in ipairs(relevant_fts) do
                        if ft == relevant_ft then
                            vim.cmd("ColorizerAttachToBuffer")
                            break
                        end
                    end
                end,
            })
        end,
    }
}
