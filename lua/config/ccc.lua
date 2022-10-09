local Self = {}

function Self.config()
	local plugin = "ccc"
	local success, ccc = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	ccc.setup({})
end

return Self
