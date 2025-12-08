return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		local eslint = lint.linters.eslint_d

		-- if Eslint error configuration not found : change MasonInstall eslint@version or npm i -g eslint at a specific version
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			php = { "php" },
			phpc = { "php" },
			swift = { "swiftlint" },
		}

	eslint.args = {
		"--no-warn-ignored",
		"--format",
		"json",
		"--stdin",
		"--stdin-filename",
		function()
			return vim.fn.expand("%:p")
		end,
	}

	-- Debounce linting to avoid running on every keystroke
	local lint_timer = nil
	local function debounced_lint()
		if lint_timer then
			lint_timer:stop()
		end
		lint_timer = vim.defer_fn(function()
			if not vim.endswith(vim.fn.bufname(), "swiftinterface") then
				require("lint").try_lint()
			end
			lint_timer = nil
		end, 500) -- Wait 500ms after last change
	end

	-- Only lint on save and after leaving insert mode (not on every keystroke)
	vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
		group = lint_augroup,
		callback = debounced_lint,
	})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
