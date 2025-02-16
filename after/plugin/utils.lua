function vcmd(cmd, ...)
	local args = { ... }
	local formatted_cmd = cmd:gsub("{}", function() return table.remove(args, 1) or "{}" end)
	vim.cmd(formatted_cmd)
end

-- Function to open URLs
function OpenUrl(url)
	-- Escape special characters in the URL
	url = vim.fn.shellescape(url)
	if vim.fn.has("win32") == 1 then
		-- Windows
		vim.fn.system(string.format('start "" %s', url))
	elseif vim.fn.has("mac") == 1 then
		-- macOS
		vim.fn.system(string.format('open %s', url))
	else
		-- Linux or other Unix-like systems
		vim.fn.system(string.format('xdg-open %s', url))
	end
end

function RenderMarkdown(content)
	return content:gsub("<[^>]+>", "")
end

return {
	vcmd = vcmd, RenderMarkdown = RenderMarkdown, OpenUrl = OpenUrl
}
