local lsp_installer_servers = require("nvim-lsp-installer.servers")
-- local utils = require "utils"

local Self = {}

function Self.install(servers, default_opts)
	require("nvim-lsp-installer").setup({})
	for server_name, server_opts in pairs(servers) do
		local server_available, server = lsp_installer_servers.get_server(server_name)

		if server_available then
			if server:is_installed() then
				local lsp = require("lspconfig")
				local opts = vim.tbl_deep_extend("force", default_opts, server_opts)

				lsp[server_name].setup(opts)
			else
				-- utils.info("Installing " .. server.name)
				print("Installing " .. server.name)
				server:install()
			end
		else
			-- utils.error(server)
			print("Server unknown" .. server)
		end
	end
end

return Self
