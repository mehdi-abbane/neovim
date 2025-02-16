vim.o.foldcolumn = "1"  -- Show fold column
vim.o.foldlevel = 99    -- Keep most folds open
vim.o.foldlevelstart = 99
vim.o.foldenable = true -- Enable folding

-- Use Treesitter + LSP for folding
require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end
})
