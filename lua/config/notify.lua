local Self = {}

-- Plugin to better folding
function Self.config()
	local plugin = "notify"
	local success, notify = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	vim.notify = notify
	notify.setup({
		background_colour = "Normal",
		fps = 30,
		icons = {
			DEBUG = "",
			ERROR = "",
			INFO = "",
			TRACE = "✎",
			WARN = "",
		},
		level = 2,
		minimum_width = 50,
		render = "default",
		stages = "slide",
		-- we got an warning about guicolors
		-- stages = "fade_in_slide_out",
		timeout = 3000,
		top_down = true,
	})
end

return Self
