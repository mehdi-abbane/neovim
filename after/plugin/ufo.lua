vim.o.foldcolumn = "1"  -- Show fold column
vim.o.foldlevel = 99    -- Open folds by default
vim.o.foldlevelstart = 99
vim.o.foldenable = true -- Enable folding

vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Reduce fold level" })
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Increase fold level" })
vim.keymap.set("n", "K", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end, { desc = "Peek fold or show hover" })


require("ufo").setup({
	fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
		local suffix = (" 󰁂 %d "):format(endLnum - lnum)
		local newVirtText = {}
		local totalWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText, chunkHl = chunk[1], chunk[2]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if totalWidth + chunkWidth + vim.fn.strdisplaywidth(suffix) > width then
				chunkText = truncate(chunkText, width - totalWidth)
				table.insert(newVirtText, { chunkText, chunkHl })
				break
			end
			table.insert(newVirtText, { chunkText, chunkHl })
			totalWidth = totalWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end
})
