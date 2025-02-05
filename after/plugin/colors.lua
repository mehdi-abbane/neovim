local Color = {}
function MakeNeovimTransparent(color)
	color = color or "tokyonight-moon"
	vim.api.nvim_command("colorscheme " .. color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "none", bg = "none" })
	vim.notify("\nChanged theme to " .. color)
end

Color.MakeNeovimTransparent = MakeNeovimTransparent

local Themes = { 'tokyonight', "tokyonight-storm", "tokyonight-day", "tokyonight-moon", "tokyonight-day", "rose-pine",
	"rose-pine-main", "rose-pine-dawn", "rose-pine-moon" }
function ChangeYourTheme()
	local choice
	print("+---------------+")
	print("|Changing Theme |\n")
	print("+-------------- +")
	for i, v in ipairs(Themes) do
		print(i .. ': ' .. v)
	end
	choice = tonumber(vim.fn.input(""))
	Color.MakeNeovimTransparent(Themes[choice])
end

MakeNeovimTransparent()
vim.api.nvim_set_keymap('n', '<leader>ct', ":lua ChangeYourTheme()<CR>", { noremap = true, silent = true })
return Color
