local Self = { packer = { wants = { "auto-session", "nvim-web-devicons" } } }

local filename_opts = {
	"filename",

	file_status = true,
	newfile_status = true,
	path = 1,
	shorting_target = 40,
	symbols = {
		modified = "+", -- Text to show when the file is modified.
		readonly = "-", -- Text to show when the file is non-modifiable or readonly.
		unnamed = "", -- Text to show for unnamed buffers.
		newfile = "[New]", -- Text to show for new created file before first writting
	},
}

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
		options = { globalstatus = true },
		sections = { lualine_c = { lsp_status_component, { "filename", path = 1 } } },
		tabline = {
			lualine_a = {
				{
					"tabs",
					mode = 2,
					tabs_color = { active = "lualine_a_normal", inactive = "lualine_b_normal" },
					max_length = vim.o.columns,
				},
			},
			lualine_c = { "filetype" },
		},
		winbar = { lualine_x = { filename_opts } },
		inactive_winbar = { lualine_x = { filename_opts } },
	})
end

return Self
