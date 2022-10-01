local Self = {}

function Self.config()
	local plugin = "Comment"
	local success, comment = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	comment.setup()
end

return Self
