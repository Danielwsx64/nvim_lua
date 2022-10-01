local Self = { packer = { wants = { "auto-session", "nvim-web-devicons" }, after = "sonokai" } }

local function lsp_status_component()
	local clients = vim.lsp.buf_get_clients()
	if #clients > 0 then
		local ok, lsp_status = pcall(require, "lsp-status")

		if ok then
			return string.format("[ %s ] %s", clients[1].name, lsp_status.status())
		end
	end

	return ""
end

function Self.config()
	local plugin = "lualine"
	local success, lualine = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	lualine.setup({
		options = { theme = "sonokai", globalstatus = true },
		sections = { lualine_c = { lsp_status_component, { "filename", path = 1 } } },
		tabline = { lualine_a = { { "tabs", mode = 2 } }, lualine_y = { "filetype" } },
		-- winbar = { lualine_x = { "filename" } },
		-- inactive_winbar = { lualine_z = { "filename" } },
	})
end

return Self
