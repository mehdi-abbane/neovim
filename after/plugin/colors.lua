local Themes = { 'tokyonight', "tokyonight-storm", "tokyonight-day", "tokyonight-moon", "tokyonight-day",
	"rose-pine",
	"rose-pine-main", "rose-pine-dawn", "rose-pine-moon", "monokai-pro", "monokai-pro-spectrum",
	'gruvbox',
	"monokai-pro-classic", "monokai-pro-octagon", "monokai-pro-machine", "monokai-pro-ristretto", "shine", "moonfly",
	"solarized-osaka", "sorbet", "vim", "ron", "delek", "desert", "default", "torte", "zaibatsu", "slate", "industry",
	"abscs", "evergarden",
}




vim.api.nvim_create_user_command("ThemeSelect", function()
	ChangeTheme(Themes)
end, {})

vim.api.nvim_set_keymap('n', '<leader>ct', ":ThemeSelect<CR>", { noremap = true, silent = true })
