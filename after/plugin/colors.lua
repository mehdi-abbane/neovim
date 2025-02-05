local ThemeManager = require("after.plugin.theme.ThemeManager")
local Themes = { 'tokyonight', "tokyonight-storm", "tokyonight-day", "tokyonight-moon", "tokyonight-day", "rose-pine",
	"rose-pine-main", "rose-pine-dawn", "rose-pine-moon", "monokai-pro", "monokai-pro-spectrum",
	"monokai-pro-classic", "monokai-pro-octagon", "monokai-pro-machine", "monokai-pro-ristretto" }

vim.api.nvim_create_user_command("ThemeSelect", function() ThemeManager.showThemePopup(Themes) end, {})
vim.api.nvim_set_keymap('n', '<leader>ct', ":ThemeSelect<CR>", { noremap = true, silent = true })
ThemeManager.makeNeovimTheme(nil, Themes) -- Use the first theme by default
