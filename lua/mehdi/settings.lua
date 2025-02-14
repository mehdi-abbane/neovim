vim.wo.number = true
vim.opt.pumheight = 10
local width = 50
local height = 3
local content = {
	' ',
	"<b> Hey do not forget what you are RUNNING after !!!!</b>",

}

local window = OpenWindow(width, height, content, "top_right", "#ff00000")

vim.defer_fn(function()
	if vim.api.nvim_win_is_valid(window.win) then
		vim.api.nvim_win_close(window.win, true)
	end
end, 1500)
