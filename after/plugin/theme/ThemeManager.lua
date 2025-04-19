function SetHighlight(group, options)
	vim.api.nvim_set_hl(0, group, options)
end

function ApplyTransparency()
	-- Transparent background for general UI elements
	SetHighlight("Normal", { bg = "none" })
	SetHighlight("NormalNC", { bg = "none" })
	SetHighlight("NormalFloat", { bg = "none" })
	SetHighlight("NvimTreeNormal", { bg = "none" })
	SetHighlight("StatusLine", { bg = "none" })
	SetHighlight("StatusLineNC", { bg = "none" })
	SetHighlight("TabLine", { bg = "none" })
	SetHighlight("TabLineFill", { bg = "none" })
	SetHighlight("TabLineSel", { bg = "none" })
	SetHighlight("VertSplit", { bg = "none" })
	SetHighlight("WinSeparator", { bg = "none" })
	SetHighlight("SignColumn", { bg = "none" })
	SetHighlight("EndOfBuffer", { bg = "none" })
	vim.cmd("highlight FloatBorder guifg=NONE guibg=NONE")
end

local function SetColorScheme(color)
	vim.api.nvim_command("colorscheme " .. color)
end

function ApplyTheme(color)
	SetColorScheme(color)
	ApplyTransparency()
end

local function CreateContent(themes)
	-- Helper to remove simple HTML tags for length calculation.
	local function stripTags(s)
		return s:gsub("<.->", "")
	end

	local lines = {}
	local themeCount = #themes
	local isTwoColumns = themeCount > 30

	if not isTwoColumns then
		-- ONE-COLUMN MODE
		local entries = {}
		local maxEntryWidth = 0

		-- Build entries and compute maximum plain-text width.
		for i, theme in ipairs(themes) do
			local entry = string.format("<b>%2d</b>: %s", i, theme)
			table.insert(entries, entry)
			local entryLen = #stripTags(entry)
			if entryLen > maxEntryWidth then
				maxEntryWidth = entryLen
			end
		end

		-- Optionally add some padding.
		local innerWidth = maxEntryWidth + 2
		local totalWidth = innerWidth + 2

		-- Helper to center text within a given width.
		local function center(text, width)
			local plain = stripTags(text)
			local textLen = #plain
			if textLen > width then
				text = text:sub(1, width - 3) .. "..."
				plain = stripTags(text)
				textLen = #plain
			end
			local padLeft = math.floor((width - textLen) / 2)
			local padRight = width - textLen - padLeft
			return string.rep(" ", padLeft) .. text .. string.rep(" ", padRight)
		end

		-- Build header and title.
		table.insert(lines, "  <h1>+" .. string.rep("-", innerWidth) .. "+</h1>")
		local title = "Select Theme"
		local titleLine = "  <h1>|" .. center(title, innerWidth) .. "|</h1>"
		table.insert(lines, titleLine)
		table.insert(lines, "  <b>+" .. string.rep("-", innerWidth) .. "+</b>")

		-- Build content lines.
		for _, entry in ipairs(entries) do
			table.insert(lines, "  |" .. center(entry, innerWidth) .. "|")
		end

		-- Build footer.
		table.insert(lines, "  <h1>+" .. string.rep("-", innerWidth) .. "+</h1>")
		table.insert(lines, "     Select number or <b>q</b> to cancel ")
		return lines, totalWidth
	else
		-- TWO-COLUMN MODE
		local half = math.ceil(themeCount / 2)
		local leftEntries = {}
		local rightEntries = {}
		local leftMax = 0
		local rightMax = 0

		for i = 1, half do
			local leftEntry = string.format("<b>%2d</b>: %s", i, themes[i])
			table.insert(leftEntries, leftEntry)
			local leftLen = #stripTags(leftEntry)
			if leftLen > leftMax then leftMax = leftLen end

			local rightIndex = i + half
			local rightEntry = ""
			if rightIndex <= themeCount then
				rightEntry = string.format("<b>%2d</b>: %s", rightIndex, themes[rightIndex])
			end
			table.insert(rightEntries, rightEntry)
			local rightLen = #stripTags(rightEntry)
			if rightLen > rightMax then rightMax = rightLen end
		end

		-- Add padding (optional, e.g. 2 extra spaces per column)
		leftMax = leftMax + 2
		rightMax = rightMax + 2
		local innerWidth = leftMax + rightMax + 1 -- plus one separator between columns
		local totalWidth = innerWidth + 2

		-- Helper to center text within a given width.
		local function center(text, width)
			local plain = stripTags(text)
			local textLen = #plain
			if textLen > width then
				text = text:sub(1, width - 3) .. "..."
				plain = stripTags(text)
				textLen = #plain
			end
			local padLeft = math.floor((width - textLen) / 2)
			local padRight = width - textLen - padLeft
			return string.rep(" ", padLeft) .. text .. string.rep(" ", padRight)
		end

		-- Build header and title.
		table.insert(lines, "  <h1>+" .. string.rep("-", leftMax) .. "+" .. string.rep("-", rightMax) .. "+</h1>")
		local title = "Select Theme"
		local combinedWidth = leftMax + rightMax + 1
		local titleLine = "  <h1>|" .. center(title, combinedWidth) .. "|</h1>"
		table.insert(lines, titleLine)
		table.insert(lines, "  <b>+" .. string.rep("-", leftMax) .. "+" .. string.rep("-", rightMax) .. "+</b>")

		-- Build content lines.
		for i = 1, half do
			local leftEntry = leftEntries[i] or ""
			local rightEntry = rightEntries[i] or ""
			local leftCentered = center(leftEntry, leftMax)
			local rightCentered = center(rightEntry, rightMax)
			table.insert(lines, "  |" .. leftCentered .. "|" .. rightCentered .. "|")
		end

		-- Build footer.
		table.insert(lines, "  <h1>+" .. string.rep("-", leftMax) .. "+" .. string.rep("-", rightMax) .. "+</h1>")
		table.insert(lines, "     Select number or <b>q</b> to cancel ")
		return lines, (totalWidth + 4)
	end
end
local function SetTheme(win, index, themes)
	local theme = themes[index]
	if theme then
		ApplyTheme(theme)
		vim.api.nvim_win_close(win, true) -- Close the window
		print("Theme set to: " .. theme)
	end
end
local function SetKeymaps(buf, win, themes)
	for i, _ in ipairs(themes) do
		vim.api.nvim_buf_set_keymap(buf, "n", tostring(i), "", {
			noremap = true,
			silent = true,
			callback = function() SetTheme(win, i, themes) end,
		})
	end
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<CR>", {
		noremap = true,
		silent = true,
	})
end

function ChangeTheme(themes)
	local content, width = CreateContent(themes)
	local window = OpenWindow(27, 30, content, "center", nil, "gruvbox")
	SetKeymaps(window.buf, window.win, themes)
	ApplyTheme("abscs")
end

ApplyTheme("abscs")
return { ChangeTheme = ChangeTheme, ApplyTheme = ApplyTheme }
