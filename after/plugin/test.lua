local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Define a function to search nearest bracket and visually select inside
local function nearest_select(char)
	local map_cmd = string.format(":silent! normal! m'[%svi%s<CR>", char, char)
	return map_cmd
end

-- Mapping keys for various characters
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

