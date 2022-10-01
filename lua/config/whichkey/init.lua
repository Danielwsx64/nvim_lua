local Self = {}

function Self.config()
	local plugin = "which-key"
	local success, whichkey = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	local keymapping = require("config.whichkey.keymapping")

	whichkey.setup({ window = { border = "single", position = "bottom" } })

	keymapping.register()
end

return Self
