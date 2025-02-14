function makeTime()
	return { os.date('<b>                <color=#ff0000>%Y-%m-%d %H:%M:%S</color></b>      ') }
end

vim.api.nvim_create_user_command("ShowTimePopUp", function()
	OpenWindow(50, 2, makeTime(), "bottom_right", "#000000", "#")
end, {})
vim.api.nvim_set_keymap('n', '<leader>st', ":ShowTimePopUp<CR>", { noremap = true, silent = true })
