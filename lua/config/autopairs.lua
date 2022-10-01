local Self = {}

function Self.config()
	local plugin = "nvim-autopairs"
	local success, autopairs = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	autopairs.setup({ check_ts = true })
	autopairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
	autopairs.add_rules(require("nvim-autopairs.rules.endwise-elixir"))
end

return Self
