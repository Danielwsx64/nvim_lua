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

	cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")

	return fist_sync
end

function Self.setup()
	local first_sync = bootstrap_packer()
	local packer = require("packer")

	packer.init(packer_config)
	packer.startup(require("plugins").get_plugins(first_sync))
end

return Self
