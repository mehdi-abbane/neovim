function vcmd(cmd, ...)
	local args = { ... }
	local formatted_cmd = cmd:gsub("{}", function() return table.remove(args, 1) or "{}" end)
	vim.cmd(formatted_cmd)
end

-- Function to open URLs
function open_url(url)
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

-- Function to handle <a> tags and open URLs on Enter
function handle_links()
	-- Get the current line and cursor position
	local line = vim.api.nvim_get_current_line()
	local col = vim.fn.col(".") - 1 -- Convert to 0-based index

	-- Match <a href="URL">Text</a> patterns
	for url, text in line:gmatch('<a href="(.-)">(.-)</a>') do
		-- Check if the cursor is on the link text
		local start_pos, end_pos = line:find('<a href="' .. url .. '">' .. text .. '</a>', 1, true)
		if start_pos and col >= start_pos - 1 and col <= end_pos - 1 then
			-- If the cursor is on the link, open the URL
			open_url(url)
			return
		end
	end

	-- If no link is found under the cursor, print a message
	print("No link found under the cursor.")
end

-- Map Enter to handle_links in normal mode
vim.api.nvim_set_keymap("n", "<CR>", "", {
	noremap = true,
	callback = handle_links,
})

-- Function to parse HTML content and apply highlights
function parseHTMLContent(content, buf)
	if type(content) == "table" then
		content = table.concat(content, "\n") -- Convert table to a single string
	end

	local parsedLines = {}
	local highlights = {}

	local tagPatterns = {
		["b"] = { "BoldHighlight", "gui=bold" },
		["i"] = { "ItalicHighlight", "gui=italic" },
		["u"] = { "UnderlineHighlight", "gui=underline" }
	}

	-- Define highlight groups for bold, italic, underline
	for tag, data in pairs(tagPatterns) do
		vim.cmd(string.format("highlight %s %s", data[1], data[2]))
	end

	-- Define highlight for links
	vim.cmd("highlight LinkHighlight guifg=#00aaff gui=underline")

	local function applyTagHighlight(line, tag, hlGroup)
		local pattern = "<" .. tag .. ">(.-)</" .. tag .. ">"
		local newLine = line
		local startIdx = 1

		while true do
			local s, e, innerText = newLine:find(pattern, startIdx)
			if not s then break end
			newLine = newLine:sub(1, s - 1) .. innerText .. newLine:sub(e + 1)
			table.insert(highlights, { hlGroup, #parsedLines, s - 1, s - 1 + #innerText })
			startIdx = s + #innerText
		end

		return newLine
	end

	for line in content:gmatch("[^\r\n]+") do
		-- Apply formatting tags
		for tag, data in pairs(tagPatterns) do
			line = applyTagHighlight(line, tag, data[1])
		end

		-- Handle color: <color=#ff0000>Text</color>
		line = line:gsub("(<color=(#?[%w]+)>(.-)</color>)", function(_, color, text)
			local highlightName = "ColorHighlight" .. color:gsub("#", "")
			vim.cmd(string.format("highlight %s guifg=%s", highlightName, color))
			table.insert(highlights, { highlightName, #parsedLines, 0, #text })
			return text
		end)

		-- Handle links: <a href="https://example.com">Click here</a>
		line = line:gsub('<a href="(.-)">(.-)</a>', function(url, text)
			local linkText = text .. " 🔗" -- Adds an icon for clarity
			local startPos = line:find('<a href="' .. url .. '">' .. text .. '</a>', 1, true)
			local endPos = startPos + #linkText - 1
			table.insert(highlights, { "LinkHighlight", #parsedLines, startPos - 1, endPos - 1, url }) -- Store the URL
			return linkText
		end)

		table.insert(parsedLines, line)
	end

	-- Apply highlights to the buffer
	for _, hl in ipairs(highlights) do
		local hl_group, hl_line, hl_start, hl_end = unpack(hl)
		vim.api.nvim_buf_add_highlight(buf, -1, hl_group, hl_line, hl_start, hl_end)
	end

	return parsedLines, highlights
end

return {
	vcmd = vcmd, parseHTMLContent = parseHTMLContent, open_url = open_url
}
