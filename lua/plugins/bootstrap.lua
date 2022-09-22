local fn = vim.fn
local cmd = vim.cmd

local Self = {}
local packer_config = {
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
}

local function bootstrap_packer()
	local fist_sync
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

	-- Check if packer.nvim is installed
	if fn.empty(fn.glob(install_path)) > 0 then
		fist_sync = fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})

		print("Packer installed in: " .. install_path)

		cmd([[packadd packer.nvim]])
	end

	return fist_sync
end

function Self.setup()
	local first_sync = bootstrap_packer()
	local packer = require("packer")

	packer.init(packer_config)
	packer.startup(require("plugins").get_plugins(first_sync))
end

function Self.reload()
	package.loaded["plugins"] = nil
	require("plugins.bootstrap").setup()
	require("packer").sync()

	for pkg, tbl in pairs(package.loaded) do
		if string.match(pkg, "^config%.") then
			if type(tbl.setup) == "function" then
				print(pkg)
				tbl.setup()
			end
		end
	end

	-- cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
	-- vim.cmd("PackerSync")
	-- require("plugins.bootstrap").setup()
	-- vim.api.nvim_create_autocmd("BufWritePost", {
	-- 	group = vim.api.nvim_create_augroup("PackerConfigSyncGroup", { clear = true }),
	-- 	callback = function()
	-- 	end,
	-- })
end

return Self
