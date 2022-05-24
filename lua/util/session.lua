local cmd = vim.cmd
local Self = {}

function Self.close_session()
  cmd("DeleteSession")
  cmd("qa!")
end

return Self
