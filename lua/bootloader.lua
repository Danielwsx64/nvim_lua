local Self = {}

function Self.startup()
	local first_sync = Self.install_packer_if_needed()

	local success, packer = pcall(require, "packer")

	if not success then
		vim.notify("Failed to load packer on bootloader startup", vim.log.levels.ERROR)

		return false
	end

	packer.init({
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	})

	if first_sync then
		Self.sync_plugins()
	else
		Self.reload_packer_plugins()
	end
end

function Self.reload_packer_plugins()
	local packer = require("packer")

	local plugins_list = Self.force_require("plugins").plugins_list

	for _, plugin_info in ipairs(plugins_list) do
		if type(plugin_info) == "string" then
			plugin_info = { plugin_info }
		end

		local packer_plugin = { plugin_info[1] }

		for key, value in pairs(Self.get_plugin_packer_info(plugin_info[2])) do
			packer_plugin[key] = value
		end

		packer_plugin.run = plugin_info.run

		packer.use(packer_plugin)
	end
end

function Self.sync_plugins()
	local packer = require("packer")
	packer.reset()
	Self.reload_packer_plugins()
	packer.sync()
end

function Self.get_plugin_packer_info(config_file)
	if config_file == nil then
		return {}
	end

	local module_namespace = "config." .. config_file
	local packer_info = { config = Self.config_for(module_namespace) }

	local success, config_module = pcall(Self.force_require, module_namespace)

	if not success then
		vim.notify(
			"Couldn't load config module " .. config_module .. ".lua, check if the file exists",
			vim.log.levels.ERROR
		)
		return packer_info
	end

	if type(config_module.packer) == "table" then
		local packer_copy = vim.deepcopy(config_module.packer)
		packer_copy.config = packer_info.config
		return packer_copy
	end

	return packer_info
end

function Self.config_for(module)
	local template = [[
  do
    local module = "%s"

    local luacache = (_G.__luacache or {}).cache
    if luacache then
      luacache[module] = nil
    end

    package.loaded[module] = nil

    local success, loaded_module = pcall(require, module)

    if not success then
      vim.notify("Couldn't load config module " .. module .. ".lua, check if the file exists", vim.log.levels.ERROR)
    else
      loaded_module.config()
    end
  end
  ]]

	return string.format(template, module)
end

function Self.force_require(module_name)
	-- Handle impatient.nvim automatically.
	local luacache = (_G.__luacache or {}).cache

	package.loaded[module_name] = nil

	if luacache then
		luacache[module_name] = nil
	end

	return require(module_name)
end

function Self.install_packer_if_needed()
	local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

	-- Check if packer.nvim is installed
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})

		print("Packer installed in: " .. install_path)

		vim.cmd([[packadd packer.nvim]])

		return true
	end

	return false
end

return Self
