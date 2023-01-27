local Self = {}

function Self.config()
	local plugin = "themer"
	local success, themer = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	-- Remove this when learn how to define by themer
	-- local colors = require("themer.modules.core.api").get_cp("sonokai_deep")
	-- vim.cmd("highlight symbol guifg=" .. colors.remaps.plugins.treesitter.TSSymbol.fg)
	-- vim.cmd("highlight symbol guifg=#85d3f2")
	-- It didnt work

	themer.setup({
		colorscheme = "sonokai_deep", -- default colorscheme
		enable_installer = true,

		langs = { html = true, md = true },

		-- remaps = {
		-- 	palette = {
		-- 		globals = {
		-- 			remaps = {
		-- 				plugins = {
		-- 					treesitter = {
		-- 						["@symbol"] = { fg = "#76cce0" },
		-- 					},
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- },

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
