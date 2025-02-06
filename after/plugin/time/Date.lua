function makeTime()
	return { os.date('               %Y-%m-%d %H:%M:%S') }
end

vim.api.nvim_create_user_command("ShowTimePopUp", function()
	OpenWindow(50, 1, makeTime(), "bottom_right")
end, {})
vim.api.nvim_set_keymap('n', '<leader>st', ":ShowTimePopUp<CR>", { noremap = true, silent = true })
