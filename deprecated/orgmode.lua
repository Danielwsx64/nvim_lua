-- local Self = {}
--
-- -- Plugin to better folding
-- function Self.config()
-- 	local plugin = "orgmode"
-- 	local success, orgmode = pcall(require, plugin)
--
-- 	if not success then
-- 		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
-- 		return
-- 	end
--
-- 	orgmode.setup({
-- 		org_agenda_files = "~/orgmode/*",
-- 		org_default_notes_file = "~/orgmode/notes.org",
-- 	})
--
-- 	orgmode.setup_ts_grammar()
-- end
--
-- return Self
