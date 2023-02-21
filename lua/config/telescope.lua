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
	local layout_actions = require("telescope.actions.layout")

	telescope.setup({
		defaults = {
			path_display = { "truncate" },
			wrap_results = true,
			layout_strategy = "flex",
			cycle_layout_list = { "vertical", "horizontal", "bottom_pane" },

			mappings = {
				i = {
					-- replace default qflist actions
					["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.smart_add_to_qflist + actions.open_qflist,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,

					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<A-l>"] = layout_actions.cycle_layout_next,
					["<C-l>"] = layout_actions.cycle_layout_prev,
					["<A-p>"] = layout_actions.toggle_preview,
					["<A-c>"] = layout_actions.toggle_prompt_position,
					["<A-m>"] = layout_actions.toggle_mirror,
				},

				n = {
					["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
				},
			},
		},
	})

	local extensions = {
		"project",
		"projects",
		"fzf",
		"file_browser",
		"neoclip",
		"ag",
		"luasnip",
		"danielws",
		"notify",
		"themes",
	}

	for _, extension in ipairs(extensions) do
		local extension_load, _ = pcall(telescope.load_extension, extension)

		if not extension_load then
			vim.notify("Failed to load Telescope extension: " .. extension, vim.log.levels.ERROR)
		end
	end
end

return Self
