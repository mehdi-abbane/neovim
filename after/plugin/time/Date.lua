function makeTime()
	local content = {
		'                <b>Time</b>   |   <b>Date</b>'
		, '            <b>' .. os.date("%H:%M:%S") .. ' </b>  |  <b>' .. os.date("%Y-%m-%d") .. '</b>'
	}
	return content
end

vim.api.nvim_create_user_command("ShowTimePopUp", function()
	OpenWindow(50, 2, makeTime(), "bottom_right", "#000000", "#")
end, {})
vim.api.nvim_set_keymap('n', '<leader>st', ":ShowTimePopUp<CR>", { noremap = true, silent = true })
