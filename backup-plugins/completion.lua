return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot", "Kaiser-Yang/blink-cmp-avante" },

		version = "v0.*",

		opts = {
			keymap = { preset = "default" },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			signature = { enabled = true },

			sources = {
				-- default = { "avante", "copilot", "snippets", "lsp", "buffer", "path" },
				default = { "snippets", "lsp", "buffer", "path" },
				-- providers = {
				-- 	copilot = {
				-- 		name = "copilot",
				-- 		module = "blink-copilot",
				-- 		score_offset = 100,
				-- 		async = true,
				-- 	},
				-- 	avante = {
				-- 		module = "blink-cmp-avante",
				-- 		name = "Avante",
				-- 		opts = {
				-- 			-- options for blink-cmp-avante
				-- 		},
				-- 	},
				-- },
			},
		},
	},
}
