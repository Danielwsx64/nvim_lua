local Self = {
	packer = {
		wants = {
			-- "project.nvim",
			-- "telescope-project.nvim",
			-- "session-lens",
			"plenary.nvim",
			"popup.nvim",
			"telescope-fzf-native.nvim",
			"telescope-file-browser.nvim",
			"nvim-neoclip.lua",
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
			-- layout_strategy = "flex", -- não funcionou o flex
			layout_strategy = "vertical",
			cycle_layout_list = { "horizontal", "bottom_pane", "vertical" },

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
					["<C-x>"] = actions.delete_buffer,
				},

				n = {
					["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
				},
			},
		},
	})

	local extensions = {
		-- "project",
		-- "projects",
		"fzf",
		"file_browser",
		"neoclip",
		"luasnip",
		"danielws",
		"notify",
	}

	for _, extension in ipairs(extensions) do
		local extension_load, _ = pcall(telescope.load_extension, extension)

		if not extension_load then
			vim.notify("Failed to load Telescope extension: " .. extension, vim.log.levels.ERROR)
		end
	end
end

return Self
