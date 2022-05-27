local api = vim.api

local Self = {}

function Self.setup()
	local status_ok, formatter = pcall(require, "formatter")

	if not status_ok then
		return
	end

	local util = require("formatter.util")

	formatter.setup({
		logging = true,
		filetype = {
			lua = {
				require("formatter.filetypes.lua").stylua,
			},
			elixir = {
				function()
					-- "--dot-formatter",
					return {
						exe = "mix",
						args = { "format", " -" },
						stdin = true,
					}
				end,
			},
		},
	})

	local group = api.nvim_create_augroup("AutoFormat", { clear = true })
	api.nvim_create_autocmd("BufWritePost", { group = group, command = "FormatWrite" })
end

return Self
