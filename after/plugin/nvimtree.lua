vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_ignore = { '.git', '.env' } -- Add other patterns if needed
require("nvim-tree").setup({
	filters = {
		dotfiles = false,
	},
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})
