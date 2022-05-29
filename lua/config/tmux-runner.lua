local api = vim.api
local cmd = vim.cmd
local env = vim.env

local Self = { attached = false }

function Self.setup()
	require("tmux-runner").setup()

	if env.TMUX then
		local group = api.nvim_create_augroup("TmuxRunner", { clear = true })

		api.nvim_create_autocmd("VimEnter", {
			group = group,
			callback = function()
				if not Self.attached then
					cmd("VtrAttachToPane")
					Self.attached = true
				end
			end,
		})
	end
end

return Self
