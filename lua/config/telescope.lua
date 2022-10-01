local Self = {
	packer = {
		wants = {
			"plenary.nvim",
			"popup.nvim",
			"telescope-fzf-native.nvim",
			"telescope-project.nvim",
			"telescope-file-browser.nvim",
			"project.nvim",
			"nvim-neoclip.lua",
			"session-lens",
		},
	},
}

function Self.config()
	local plugin = "telescope"
	local success, telescope = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			path_display = { "truncate" },
			wrap_results = true,
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

	telescope.load_extension("project")
	telescope.load_extension("projects")
	telescope.load_extension("fzf")
	telescope.load_extension("file_browser")
	telescope.load_extension("neoclip")
	telescope.load_extension("gh")
	telescope.load_extension("ag")
	telescope.load_extension("luasnip")
	telescope.load_extension("danielws")
	telescope.load_extension("notify")
	telescope.load_extension("termfinder")
end

return Self
