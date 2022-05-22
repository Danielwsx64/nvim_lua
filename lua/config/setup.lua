local Self = {}

function Self.setup(package)
	local setup_template = [[
  do
    local pkg_path = "config." .. "%s"
    local pkg_status, pkg = pcall(require, pkg_path)

    if not pkg_status then
      print("Could load package setup " .. pkg_path .. ".lua")
    else
      pkg.setup()
    end
  end
]]
	return string.format(setup_template, package)
end

return Self
