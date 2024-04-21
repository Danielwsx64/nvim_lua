return {
	"NeogitOrg/neogit",
	dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
	branch = "nightly",
	opts = { disable_builtin_notifications = true, integrations = { diffview = true } },
}
