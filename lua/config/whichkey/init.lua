local Self = {}

function Self.setup()
	local status_ok, whichkey = pcall(require, "which-key")

	if not status_ok then
		return
	end

	local keymapping = require("config.whichkey.keymapping")

	local conf = {
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
		},
	}

	whichkey.setup(conf)
	keymapping.register()
end

return Self
