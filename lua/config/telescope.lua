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
