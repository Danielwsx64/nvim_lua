local Self = {}

-- alpha is a fast and fully customizable greeter for neovim.
-- see: https://github.com/goolord/alpha-nvim

local header = {
	[[                                                                              ]],
	[[                                    ██████                                    ]],
	[[                                ████▒▒▒▒▒▒████                                ]],
	[[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
	[[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
	[[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
	[[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
	[[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
	[[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
	[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
	[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
	[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
	[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
	[[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
	[[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
	[[                        ██      ██      ████      ████                        ]],
	[[                                                                              ]],
	[[                                                                              ]],
}

function Self.setup()
	local status_ok, alpha = pcall(require, "alpha")
	if not status_ok then
		return
	end

	local function footer()
		-- Number of plugins
		local total_plugins = #vim.tbl_keys(packer_plugins)
		local datetime = os.date("%d-%m-%Y  %H:%M:%S")
		local plugins_text = "\t" .. total_plugins .. " plugins  " .. datetime

		-- Quote
		local fortune = require("alpha.fortune")
		local quote = table.concat(fortune(), "\n")

		return plugins_text .. "\n" .. quote
	end

	local dashboard = require("alpha.themes.dashboard")
	local button = dashboard.button
	dashboard.leader = "daniel"

	dashboard.section.header.val = header
	dashboard.section.header.opts.hl = "Type"

	dashboard.section.buttons.val = {
		button("e", "  New file", "<cmd>ene <CR>"),
		button("SPC f f", "  Find file", "<cmd>Telescope find_files<cr>"),
		button("SPC s l", "﫻 Sessions", "<CMD>Telescope session-lens search_session<CR>"),
		button("SPC c e", "  Configuration", ":e $MYVIMRC <CR>"),
		button("SCP f p", " Projects", "<cmd>lua require'telescope'.extensions.project.project{}<cr>"),
		button("SPC z s", "  Packer sync", "<cmd>PackerSync<CR>"),
	}

	dashboard.section.buttons.opts.hl = "Function"
	dashboard.section.buttons.opts.hl_shortcut = "Type"

	dashboard.section.footer.val = footer()
	dashboard.section.footer.opts.hl = "Constant"

	alpha.setup({
		layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			dashboard.section.footer,
		},
		opts = {
			margin = 5,
			noautocmd = true,
		},
	})
end

return Self

--
--  /$$$$$$$                      /$$           /$$
-- | $$__  $$                    |__/          | $$
-- | $$  \ $$  /$$$$$$  /$$$$$$$  /$$  /$$$$$$ | $$       /$$  /$$  /$$  /$$$$$$$
-- | $$  | $$ |____  $$| $$__  $$| $$ /$$__  $$| $$      | $$ | $$ | $$ /$$_____/
-- | $$  | $$  /$$$$$$$| $$  \ $$| $$| $$$$$$$$| $$      | $$ | $$ | $$|  $$$$$$
-- | $$  | $$ /$$__  $$| $$  | $$| $$| $$_____/| $$      | $$ | $$ | $$ \____  $$
-- | $$$$$$$/|  $$$$$$$| $$  | $$| $$|  $$$$$$$| $$      |  $$$$$/$$$$/ /$$$$$$$/
-- |_______/  \_______/|__/  |__/|__/ \_______/|__/       \_____/\___/ |_______/
--
--                                                        [ Wellcome to NeoVim ]
