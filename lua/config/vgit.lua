local Self = {}

function Self.setup()
	local status_ok, vgit = pcall(require, "vgit")

	if not status_ok then
		return
	end

	vgit.setup({
		-- keymaps = {
		-- 	["n <C-k>"] = "hunk_up",
		-- 	["n <C-j>"] = "hunk_down",
		-- 	["n <leader>gs"] = "buffer_hunk_stage",
		-- 	["n <leader>gr"] = "buffer_hunk_reset",
		-- 	["n <leader>gp"] = "buffer_hunk_preview",
		-- 	["n <leader>gb"] = "buffer_blame_preview",
		-- 	["n <leader>gf"] = "buffer_diff_preview",
		-- 	["n <leader>gh"] = "buffer_history_preview",
		-- 	["n <leader>gu"] = "buffer_reset",
		-- 	["n <leader>gg"] = "buffer_gutter_blame_preview",
		-- 	["n <leader>gl"] = "project_hunks_preview",
		-- 	["n <leader>gd"] = "project_diff_preview",
		-- 	["n <leader>gq"] = "project_hunks_qf",
		-- 	["n <leader>gx"] = "toggle_diff_preference",
		-- },
		settings = { live_blame = { enabled = false }, live_gutter = { enabled = false } },
	})
end
require("vgit").setup()

return Self
