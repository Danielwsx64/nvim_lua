local Self = {}

-- Theme color Setup

function Self.setup()
	vim.g.sonokai_better_performance = 1
	vim.g.sonokai_style = "default"

	vim.cmd("colorscheme sonokai")
	-- vim.g.material_style = "darker"
end

local function apply_material_theme(theme)
	require("material.functions").change_style(theme)
	vim.cmd("colorscheme material")
end

local function apply_sonokay_theme(theme)
	vim.g.sonokai_style = theme
	vim.cmd("colorscheme sonokai")
end

local themes_apply_fn = {
	material = apply_material_theme,
	sonokai = apply_sonokay_theme,
}

function Self.picker()
	local action_state = require("telescope.actions.state")
	local actions = require("telescope.actions")
	local conf = require("telescope.config").values
	local finders = require("telescope.finders")
	local pickers = require("telescope.pickers")
	local themes = require("telescope.themes")

	local opts = themes.get_dropdown({})

	local results = {
		{ "Material darker", "material", "darker" },
		{ "Material lighter", "material", "lighter" },
		{ "Material oceanic", "material", "oceanic" },
		{ "Material palenight", "material", "palenight" },
		{ "Material deep ocean", "material", "deep ocean" },
		{ "Sonokai", "sonokai", "default" },
		{ "Sonokai Andromeda", "sonokai", "andromeda" },
		{ "Sonokai Atlantis", "sonokai", "atlantis" },
		{ "Sonokai Shusia", "sonokai", "shusia" },
		{ "Sonokai Maia", "sonokai", "maia" },
		{ "Sonokai Espresso", "sonokai", "espresso" },
	}

	local attach_mappings = function(bufnr, _)
		actions.select_default:replace(function()
			actions.close(bufnr)
			local selection = action_state.get_selected_entry().value

			vim.notify("Color scheme changed to " .. selection[1], "info", { title = "Color Scheme" })

			themes_apply_fn[selection[2]](selection[3])
		end)

		return true
	end

	pickers.new(opts, {
		prompt_title = "Daniel Change colorscheme",
		finder = finders.new_table({
			results = results,
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry[1],
					ordinal = entry[1],
				}
			end,
		}),
		sorter = conf.generic_sorter(opts),
		attach_mappings = attach_mappings,
	}):find()
end

return Self
