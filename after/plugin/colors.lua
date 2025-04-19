local Themes = { "rose-pine",
	"rose-pine-main", "rose-pine-dawn", "rose-pine-moon",
	'gruvbox',
	"shine", "moonfly",
	"solarized-osaka", "sorbet", "vim", "ron", "delek", "desert", "default", "torte", "zaibatsu", "slate", "industry",
	"abscs", "evergarden", "habamax"
}




vim.api.nvim_create_user_command("ThemeSelect", function()
	ChangeTheme(Themes)
end, {})

vim.api.nvim_set_keymap('n', '<leader>ct', ":ThemeSelect<CR>", { noremap = true, silent = true })
