-- theme_manager.lua

-- Helper functions to set highlight groups
local function setHighlight(group, options)
	vim.api.nvim_set_hl(0, group, options)
end

-- Apply transparency settings to various highlight groups
local function applyTransparency()
	setHighlight("Normal", { bg = "none" })
	setHighlight("NormalFloat", { bg = "none" })
	setHighlight("NvimTreeNormal", { bg = "none" })
	setHighlight("NormalNC", { bg = "none" })
	setHighlight("WinSeparator", { fg = "none", bg = "none" })
end

-- Set the Neovim colorscheme
local function setColorscheme(color)
	vim.api.nvim_command("colorscheme " .. color)
end

-- Apply theme (sets colorscheme and applies transparency)
local function applyTheme(color)
	setColorscheme(color)
	applyTransparency()
end

-- Create a buffer for a popup window
local function createPopupBuffer()
	return vim.api.nvim_create_buf(false, true)
end

-- Calculate window position for centering it
local function calculateWindowPosition(width, height)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	return row, col
end

-- Create a popup window with specified buffer, width, and height
local function createPopupWindow(buf, width, height)
	local row, col = calculateWindowPosition(width, height)
	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
	}
	return vim.api.nvim_open_win(buf, true, opts)
end

-- Populate the popup buffer with theme options
local function populatePopupBuffer(buf, themes)
	local lines = { "+---------------+", "| Select Theme  |", "+---------------+", }
	for i, theme in ipairs(themes) do
		table.insert(lines, string.format(" %d. %s", i, theme))
	end
	table.insert(lines, " Press number to select | q to cancel ")
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

local function setTheme(win, index, themes)
	local theme = themes[index]
	if theme then
		applyTheme(theme)
		vim.api.nvim_win_close(win, true) -- Close the window
		print("Theme set to: " .. theme)
	end
end
-- Set keymaps for selecting themes in the popup
local function setKeymaps(buf, win, themes, setThemeFunc)
	for i, _ in ipairs(themes) do
		vim.api.nvim_buf_set_keymap(buf, "n", tostring(i), "", {
			noremap = true,
			silent = true,
			callback = function() setThemeFunc(win, i, themes) end,
		})
	end
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<CR>", {
		noremap = true,
		silent = true,
	})
end

local function showThemePopup(themes)
	local buf = createPopupBuffer()
	local width = 40
	local height = #themes + 4
	local win = createPopupWindow(buf, width, height)

	populatePopupBuffer(buf, themes)
	setKeymaps(buf, win, themes, setTheme) -- Pass `setTheme` as an argument

	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
end

local function makeNeovimTheme(color, themes)
	color = color or "rose-pine-moon" -- Default to first theme if not specified
	applyTheme(color)
end

return {
	setHighlight = setHighlight,
	applyTransparency = applyTransparency,
	setColorscheme = setColorscheme,
	applyTheme = applyTheme,
	createPopupBuffer = createPopupBuffer,
	calculateWindowPosition = calculateWindowPosition,
	createPopupWindow = createPopupWindow,
	populatePopupBuffer = populatePopupBuffer,
	setKeymaps = setKeymaps,
	setTheme = setTheme, -- Make sure to return setTheme
	showThemePopup = showThemePopup,
	makeNeovimTheme = makeNeovimTheme
}
