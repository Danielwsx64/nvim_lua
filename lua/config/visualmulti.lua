local cmd = vim.cmd
local Self = {}

function Self.setup()
	cmd([[ 
    let g:VM_theme                      = 'olive'
    let g:VM_maps                       = {}
    let g:VM_maps["Add Cursor Down"]    = '<M-n>'   " new cursor down
    let g:VM_maps["Add Cursor Up"]      = '<M-m>'   " new cursor up
  ]])
end

return Self
