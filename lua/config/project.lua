local Self = {}

-- detection_methods = { "pattern", "lsp" },
-- patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

function Self.setup()
	require("project_nvim").setup({
		detection_methods = { ">WsLW", "!>apps", ".git", "Makefile", "package.json" },
	})
end

return Self
