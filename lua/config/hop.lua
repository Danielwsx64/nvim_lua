local Self = {}

function Self.config()
	local plugin = "hop"
	local success, hop = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	hop.setup()
end

return Self
