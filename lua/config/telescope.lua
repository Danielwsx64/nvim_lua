local Self = {}

function Self.setup()
	local status_ok, telescope = pcall(require, "telescope")

	if not status_ok then
		return
	end

	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
					["<C-h>"] = actions.select_tab,
					["<C-l>"] = actions.select_vertical,
				},
			},
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("file_browser")
end

return Self
