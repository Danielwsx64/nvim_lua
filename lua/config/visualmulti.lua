local cmd = vim.cmd
local Self = {}

function Self.setup()
	cmd([[ 
    let g:VM_leader                     = {'default': '<leader>m', 'visual': '<leader>m', 'buffer': '<leader>m'}
    let g:VM_theme                      = 'olive'
    let g:VM_maps                       = {}
    let g:VM_maps["Add Cursor Down"]    = '<M-n>'    " new cursor down
    let g:VM_maps["Add Cursor Up"]      = '<M-m>'    " new cursor up
    let g:VM_maps['Select All']         = '<C-a>'    " select all
    let g:VM_maps['Visual All']         = '<C-a>'
    let g:VM_maps['Start Regex Search'] = '<C-_>'
  ]])
end

return Self
