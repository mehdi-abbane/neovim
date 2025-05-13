local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>vi(', function()
	vim.cmd("silent! normal! m'[(") -- move to nearest (
	vim.cmd("normal! vi(")
end, opts)

vim.keymap.set('n', '<leader>vi{', function()
	vim.cmd("silent! normal! m'[{") -- move to nearest {
	vim.cmd("normal! vi{")
end, opts)

vim.keymap.set('n', '<leader>vi[', function()
	vim.cmd("silent! normal! m'[[") -- move to nearest [
	vim.cmd("normal! vi[")
end, opts)

vim.keymap.set('n', "<leader>vi'", function()
	vim.cmd("silent! normal! m'[\'") -- move to nearest '
	vim.cmd("normal! vi'")
end, opts)

vim.keymap.set('n', '<leader>vi"', function()
	vim.cmd("silent! normal! m'[\"]") -- move to nearest "
	vim.cmd("normal! vi\"")
end, opts)
vim.keymap.set("n", "<leader>e", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.api.nvim_buf_get_option(buf, "filetype")
		if ft == "netrw" then
			vim.api.nvim_win_close(win, true)
			return
		end
	end

	vim.cmd("vertical leftabove 30vsplit | Ex")
end, { noremap = true, silent = true, desc = "Toggle file explorer (netrw)" })
