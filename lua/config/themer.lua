local Self = {}

function Self.config()
	local plugin = "themer"
	local success, themer = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	themer.setup({
		colorscheme = "guna", -- default colorscheme
		enable_installer = true,
		langs = {
			html = true,
			md = true,
		},

		plugins = {
			treesitter = true,
			indentline = true,
			barbar = true,
			bufferline = true,
			cmp = true,
			gitsigns = true,
			lsp = true,
			telescope = true,
		},
	})
end

return Self
