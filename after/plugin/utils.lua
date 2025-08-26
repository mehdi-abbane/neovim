local function vcmd(cmd, ...)
	local args = { ... }
	local formatted_cmd = cmd:gsub("{}", function() return table.remove(args, 1) or "{}" end)
	vim.cmd(formatted_cmd)
end

-- Function to open URLs
function OpenUrl(url)
	url = vim.fn.shellescape(url)
	if vim.fn.has("win32") == 1 then
		-- Windows
		vim.fn.system(string.format('start "" %s', url))
	elseif vim.fn.has("mac") == 1 then
		-- macOS
		vim.fn.system(string.format('open %s', url))
	else
		vim.fn.system(string.format('xdg-open %s', url))
	end
end

function RenderMarkdown(content)
	return content:gsub("<[^>]+>", "")
end

function FileTree()
	local buf_ft = vim.bo.filetype
	if buf_ft == "netrw" then
		vim.cmd("q") -- Close netrw if it's already open
	else
		vim.cmd("Ex") -- Open netrw
	end
end

function JumpOutsideClosingBracket()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line():sub(col + 1)

	local min_pos
	for _, char in ipairs({ ")", "]", "}" }) do
		local pos = string.find(line, "%" .. char)
		if pos and (not min_pos or pos < min_pos) then
			min_pos = pos
		end
	end

	if min_pos then
		vim.api.nvim_win_set_cursor(0, { row, col + min_pos })
	else
		print("No closing bracket found to jump outside.")
	end
end

function JumpToNearestClosingBracketAndInsert()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line():sub(col + 1)
	local positions = {}
	for _, char in ipairs({ ")", "]", "}", '"' }) do
		local pos = string.find(line, "%" .. char)
		if pos then
			table.insert(positions, col + pos)
		end
	end
	if #positions > 0 then
		table.sort(positions)
		vim.api.nvim_win_set_cursor(0, { row, positions[1] - 1 })
		vim.cmd("startinsert")
	else
		print("No closing brackets found on this line.")
	end
end

return {
	vcmd = vcmd,
	RenderMarkdown = RenderMarkdown,
	OpenUrl = OpenUrl,
	JumpToNearestClosingBracketAndInsert = JumpToNearestClosingBracketAndInsert,
	JumpOutsideClosingBracket = JumpOutsideClosingBracket,
}
