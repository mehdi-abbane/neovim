function makeTime()
	local content = {
		'             <h1>Time</h1>      |     <h1>Date</h1>',
		'            <b>' .. os.date("%H:%M:%S") .. ' </b>  |  <b>' .. os.date("%Y-%m-%d") .. '</b>'
	}
	return content
end

vim.api.nvim_create_user_command("ShowTimePopUp", function()
	OpenWindow(50, 2, makeTime(), "top_right", "tokyonight")
end, {})
vim.api.nvim_set_keymap('n', '<leader>st', ":ShowTimePopUp<CR>", { noremap = true, silent = true })
