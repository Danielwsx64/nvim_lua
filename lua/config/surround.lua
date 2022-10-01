local Self = {}

function Self.config()
	local plugin = "nvim-surround"
	local success, surround = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	surround.setup({})
end

return Self
