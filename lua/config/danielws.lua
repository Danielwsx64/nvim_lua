local Self = {}

function Self.config()
	local plugin = "danielws"
	local success, danielws = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	danielws.setup({ tmux_runner = { auto_attach = false } })
end

return Self
