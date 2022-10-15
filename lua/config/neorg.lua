local Self = { packer = { wants = { "plenary.nvim" } } }

function Self.config()
	local plugin = "neorg"
	local success, neorg = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	neorg.setup({
		load = {
			["core.defaults"] = {},

			["core.keybinds"] = {
				config = {
					default_keybinds = true,
					neorg_leader = "<Leader>o",
				},
			},

			["core.norg.dirman"] = {
				config = {
					workspaces = {
						work = "~/notes/work",
						home = "~/notes/home",
						--default_workspace = "work",
					},
				},
			},

			["core.norg.journal"] = {
				config = {
					workspace = "home",
					journal_folder = "journal",
					use_folders = false,
				},
			},

			["core.presenter"] = { config = { zen_mode = "zen-mode" } },
			["core.gtd.base"] = { config = { workspace = "work" } },
			["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
		},
	})
end

return Self
