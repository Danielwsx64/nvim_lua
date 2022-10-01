local Self = {}

function Self.install(servers, default_opts)
	local plugin = "nvim-lsp-installer"
	local success, lsp_installer = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	local servers_success, lsp_installer_servers = pcall(require, plugin .. ".servers")

	if not servers_success then
		vim.notify("Failed to load " .. plugin .. ".servers", vim.log.levels.ERROR)
		return
	end

	lsp_installer.setup({})

	for server_name, server_opts in pairs(servers) do
		local server_available, server = lsp_installer_servers.get_server(server_name)

		if server_available then
			if server:is_installed() then
				local lsp = require("lspconfig")
				local opts = vim.tbl_deep_extend("force", default_opts, server_opts)

				lsp[server_name].setup(opts)
			else
				vim.notify("Installing " .. server.name)
				server:install()
			end
		else
			vim.notify("Server unknown " .. server, vim.log.levels.ERROR)
		end
	end
end

return Self
