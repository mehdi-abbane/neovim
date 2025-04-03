vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true


require('ufo').setup()
vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds" })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds" })
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = "Reduce folding level" })
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = "Increase folding level" })
vim.keymap.set('n', 'zp', function()
  require('ufo').peekFoldedLinesUnderCursor()
end, { desc = "Preview folded content" })

require('ufo').setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { 'treesitter', 'indent' }
	end
})
--

-- Option 4: disable all providers for all buffers
-- Not recommend, AFAIK, the ufo's providers are the best performance in Neovim
require('ufo').setup({
	provider_selector = function(bufnr, filetype, buftype)
		return ''
	end
})
