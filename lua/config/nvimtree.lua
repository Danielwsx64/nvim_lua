local g = vim.g
local Self = {}

local list = {
	{ key = "v", action = "vsplit" },
	{ key = "s", action = "split" },
	{ key = "t", action = "tabnew" },
}

function Self.setup()
	local status_ok, nvimtree = pcall(require, "nvim-tree")

	if not status_ok then
		return
	end

	nvimtree.setup({
		update_focused_file = {
			enable = false,
			update_cwd = false,
			ignore_list = {},
		},
		view = { width = 35, number = true, relativenumber = true, mappings = { list = list } },
		filters = { custom = { ".git" } },
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
