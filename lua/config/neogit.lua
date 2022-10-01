local Self = { packer = { wants = { "plenary.nvim", "diffview.nvim" } } }

function Self.config()
	local plugin = "neogit"
	local success, neogit = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	neogit.setup({ disable_builtin_notifications = true, integrations = { diffview = true } })
end

return Self
