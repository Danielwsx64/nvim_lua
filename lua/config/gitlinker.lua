local Self = { packer = { wants = "plenary.vim" } }

function Self.config()
	local plugin = "gitlinker"
	local success, gitlinker = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	gitlinker.setup({ mappings = nil, print_url = false })
end

function Self.open_in_browser(mode)
	local gitlinker = require("gitlinker")

	gitlinker.get_buf_range_url(mode, { action_callback = Self.open_browser })
end

function Self.copy_link(mode)
	local gitlinker = require("gitlinker")

	gitlinker.get_buf_range_url(mode)
end

function Self.open_browser(url)
	require("plenary.job"):new({ command = "firefox", args = { url } }):sync()
end

return Self
