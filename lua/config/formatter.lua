local Self = {}

local function elixir_formater()
	local config
	local formatter = { exe = "mix", args = { "format", "-" }, stdin = true }

	local buffer_name = vim.fn.expand("%:p")

	if not buffer_name then
		return formatter
	end

	local formatter_files = vim.fs.find(".formatter.exs", { type = "file", stop = "apps", limit = math.huge })

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

local function dart_formatter()
	local util = require("formatter.util")

	return {
		exe = "flutter",
		args = {
			"format",
			util.escape_path(util.get_current_buffer_file_name()),
		},
	}
end

function Self.config()
	local plugin = "formatter"
	local success, formatter = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	formatter.setup({
		logging = false,
		log_level = vim.log.levels.DEBUG,
		filetype = {
	    elixir = { elixir_formater },
			dart = { dart_formatter },

			lua = { require("formatter.filetypes.lua").stylua },
			javascript = { require("formatter.filetypes.javascript").prettier },
			javascriptreact = { require("formatter.filetypes.javascript").prettier },
			typescript = { require("formatter.filetypes.typescript").prettier },
			typescriptreact = { require("formatter.filetypes.typescript").prettier },
			rust = { require("formatter.filetypes.rust").rustfmt },
			ruby = { require("formatter.filetypes.ruby").rubocop },

			json = { require("formatter.filetypes.json").prettier },
			yaml = { require("formatter.filetypes.yaml").prettier },
			html = { require("formatter.filetypes.html").prettier },
			css = { require("formatter.filetypes.css").prettier },
		},
	})

	local group = vim.api.nvim_create_augroup("AutoFormat", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePost", { group = group, command = "FormatWrite" })
end

return Self
