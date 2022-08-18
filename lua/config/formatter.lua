local api = vim.api
local find = vim.fs.find
local expand = vim.fn.expand
local levels = vim.log.levels

local Self = {}

local function elixir_formater()
	local config
	local formatter = { exe = "mix", args = { "format", "-" }, stdin = true }

	local buffer_name = expand("%:p")

	if not buffer_name then
		return formatter
	end

	local formatter_files = find(".formatter.exs", { type = "file", stop = "apps", limit = math.huge })

	if not formatter_files[1] then
		return formatter
	end

	for index, value in ipairs(formatter_files) do
		if index == 1 then
			config = value
		else
			if
				string.match(buffer_name, string.gsub(value, ".formatter.exs", ""))
				and string.len(value) > string.len(config)
			then
				config = value
			end
		end
	end

	formatter.args = { "format", "--dot-formatter", config, "-" }

	return formatter
end

function Self.setup()
	local status_ok, formatter = pcall(require, "formatter")

	if not status_ok then
		return
	end

	formatter.setup({
		logging = false,
		log_level = levels.DEBUG,
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
