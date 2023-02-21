local Self = {}

function Self.config()
	local plugin = "todo"
	local success, todo = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	todo.setup()
end

return Self
