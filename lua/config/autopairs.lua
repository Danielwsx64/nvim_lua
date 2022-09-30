local Self = {}

function Self.setup()
	local status_ok, autopairs = pcall(require, "nvim-autopairs")

	if not status_ok then
		return
	end

	autopairs.setup({ check_ts = true })
	autopairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
	autopairs.add_rules(require("nvim-autopairs.rules.endwise-elixir"))
end

return Self
