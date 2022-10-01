local Self = { packer = { wants = { "nvim-web-devicons" } } }

local list = {
	{ key = "v", action = "vsplit" },
	{ key = "s", action = "split" },
	{ key = "t", action = "tabnew" },
}

function Self.config()
	local plugin = "nvim-tree"
	local success, nvimtree = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	nvimtree.setup({
		update_focused_file = {
			enable = false,
			update_cwd = false,
			ignore_list = {},
		},
		view = { width = 35, number = true, relativenumber = true, mappings = { list = list } },
		filters = { custom = { "\\.git" } },
		renderer = {
			icons = {
				glyphs = {
					default = "",
					symlink = "",
					folder = {
						arrow_closed = "",
						arrow_open = "",
						default = "",
						open = "",
						empty = "◉",
						empty_open = "◉",
						symlink = "",
						symlink_open = "",
					},
				},
			},
		},
	})

	-- g.nvim_tree_respect_buf_cwd = 0
end

return Self
