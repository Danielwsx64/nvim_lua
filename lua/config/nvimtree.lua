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
		view = { width = 50, number = true, relativenumber = true, mappings = { list = list } },
		filters = { custom = { ".git" } },
	})
end

return Self
