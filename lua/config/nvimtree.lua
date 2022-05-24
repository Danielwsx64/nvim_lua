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
		view = { width = 50, number = true, relativenumber = true, mappings = { list = list } },
		filters = { custom = { ".git" } },
	})

	g.nvim_tree_respect_buf_cwd = 1
end

return Self
