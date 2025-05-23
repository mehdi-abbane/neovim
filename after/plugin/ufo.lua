local ufo = require('ufo')
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- start with all folds open
vim.opt.foldlevelstart = 99
-- Basic setup
ufo.setup({
	open_fold_hl_timeout = 20,
	provider_selector = function(bufnr, filetype, buftype)
		return { 'treesitter', 'indent' }
	end,
	preview = {
		win_config = {
			border = 'rounded',
			-- winhighlight = 'Normal:Folded',
			winblend = 1
		},
		mappings = {
			scrollU = '<C-u>',
			scrollD = '<C-d>'
		}
	},
	enable_get_fold_virt_text = true,
	fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = (' 󰁂 %d '):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, 'MoreMsg' })
		return newVirtText
	end
})

-- Key mappings
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith)
vim.keymap.set('n', 'K', function()
	local winid = ufo.peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end)
