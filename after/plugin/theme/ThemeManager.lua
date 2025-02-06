function setHighlight(group, options)
	vim.api.nvim_set_hl(0, group, options)
end

function applyTransparency()
	-- Transparent background for general UI elements
	setHighlight("Normal", { bg = "none" })
	setHighlight("NormalNC", { bg = "none" })
	setHighlight("NormalFloat", { bg = "none" })
	setHighlight("NvimTreeNormal", { bg = "none" })
	setHighlight("StatusLine", { bg = "none" })
	setHighlight("StatusLineNC", { bg = "none" })
	setHighlight("TabLine", { bg = "none" })
	setHighlight("TabLineFill", { bg = "none" })
	setHighlight("TabLineSel", { bg = "none" })
	setHighlight("VertSplit", { bg = "none" })
	setHighlight("WinSeparator", { bg = "none" })
	setHighlight("SignColumn", { bg = "none" })
	setHighlight("EndOfBuffer", { bg = "none" })
end

local function setColorscheme(color)
	vim.api.nvim_command("colorscheme " .. color)
end

function applyTheme(color)
	setColorscheme(color)
	applyTransparency()
end

local function populatePopupBuffer(themes, content)
	local lines = content or { "+---------------+", "| Select Theme  |", "+---------------+", }

	for i, theme in ipairs(themes) do
		table.insert(lines, string.format(" %d. %s", i, theme))
	end
	table.insert(lines, " Press number to select | q to cancel ")
	return lines
end

local function setTheme(win, index, themes)
	local theme = themes[index]
	if theme then
		applyTheme(theme)
		vim.api.nvim_win_close(win, true) -- Close the window
		print("Theme set to: " .. theme)
	end
end
local function setKeymaps(buf, win, themes)
	for i, _ in ipairs(themes) do
		vim.api.nvim_buf_set_keymap(buf, "n", tostring(i), "", {
			noremap = true,
			silent = true,
			callback = function() setTheme(win, i, themes) end,
		})
	end
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<CR>", {
		noremap = true,
		silent = true,
	})
end

function ChangeTheme(themes)
	local width = 40
	local height = #themes + 4
	local content = populatePopupBuffer(themes)
	local window = OpenWindow(width, height, content, "center")
	local buf = window.buf
	local win = window.win
	local color = "rose-pine-moon" -- Default to first theme if not specified
	applyTheme(color)

	setKeymaps(buf, win, themes, setTheme)
end

applyTransparency()
return { ChangeTheme = ChangeTheme, applyTheme = applyTheme }
