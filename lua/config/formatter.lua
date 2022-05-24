local api = vim.api

local Self = {}

function Self.setup()
	local status_ok, formatter = pcall(require, "formatter")

	if not status_ok then
		return
	end

	local util = require("formatter.util")

	formatter.setup({
		-- All formatter configurations are opt-in
		filetype = {
			lua = {
				require("formatter.filetypes.lua").stylua,
			},
			elixir = {
				function()
					-- "--dot-formatter",
					return {
						exe = "mix",
						args = {
							"format",
							util.escape_path(util.get_current_buffer_file_path()),
							" -",
						},
						stdin = true,
					}
				end,
			},
		},
	})

	local group = api.nvim_create_augroup("AutoFormat", { clear = true })
	api.nvim_create_autocmd("BufWritePre", { group = group, command = "Format" })
end

return Self
