local Self = {}

-- detection_methods = { "pattern", "lsp" },
-- patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

function Self.config()
	local plugin = "project_nvim"
	local success, project_nvim = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	project_nvim.setup({
		detection_methods = { ">WsLW", "!>apps", ".git", "Makefile", "package.json" },
	})
end

return Self
