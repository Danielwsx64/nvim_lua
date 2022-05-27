local api = vim.api

local Self = {}

local function elixir_formater()
	return {
		exe = "mix",
		args = { "format", " -" },
		stdin = true,
	}
end

function Self.setup()
	local status_ok, formatter = pcall(require, "formatter")

	if not status_ok then
		return
	end

	local util = require("formatter.util")

	formatter.setup({
		logging = true,
		filetype = {
			elixir = { elixir_formater },

			lua = { require("formatter.filetypes.lua").stylua },
			javascript = { require("formatter.filetypes.javascript").prettier },
			typescript = { require("formatter.filetypes.typescript").prettier },
			rust = { require("formatter.filetypes.rust").rustfmt },

			json = { require("formatter.filetypes.json").prettier },
			yaml = { require("formatter.filetypes.yaml").prettier },
			html = { require("formatter.filetypes.html").prettier },
			css = { require("formatter.filetypes.css").prettier },
		},
	})

	local group = api.nvim_create_augroup("AutoFormat", { clear = true })
	api.nvim_create_autocmd("BufWritePost", { group = group, command = "FormatWrite" })
end

return Self
