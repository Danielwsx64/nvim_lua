return {
	"stevearc/conform.nvim",
	lazy = false,
	-- keys = {
	-- 	{
	-- 		"<leader>f",
	-- 		function()
	-- 			require("conform").format({ async = true, lsp_fallback = true })
	-- 		end,
	-- 		mode = "",
	-- 		desc = "[F]ormat buffer",
	-- 	},
	-- },
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			local disabled_languages = { c = true, cpp = true }

			return {
				timeout_ms = 2000,
				lsp_format = disabled_languages[vim.bo[bufnr].filetype] and "never" or "fallback",
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescriptreact = { "prettier" },
			typescrip = { "prettier" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			-- javascript = { { "prettierd", "prettier" } },
		},
	},
}
