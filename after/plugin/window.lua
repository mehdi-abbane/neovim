local function createPopupBuffer()
	return vim.api.nvim_create_buf(false, true)
end

local function calculateWindowPosition(width, height, position)
	local ui = vim.api.nvim_list_uis()[1]
	local screen_width, screen_height = ui.width, ui.height

	local positions = {
		["top_left"]      = { 0, 0 },
		["top_center"]    = { (screen_width - width) / 2, 0 },
		["top_right"]     = { screen_width - width, 0 },
		["bottom_left"]   = { 0, screen_height - height },
		["bottom_center"] = { (screen_width - width) / 2, screen_height - height },
		["bottom_right"]  = { screen_width - width, screen_height - height },
		["left_center"]   = { 0, (screen_height - height) / 2 },
		["right_center"]  = { screen_width - width, (screen_height - height) / 2 },
		["center"]        = { (screen_width - width) / 2, (screen_height - height) / 2 },
	}

	return positions[position] or positions["top_left"]
end

local function createPopupWindow(buf, width, height, row, col, opts, pos)
	local winPos = calculateWindowPosition(width, height, pos)
	opts = opts or {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row or winPos[2],
		col = col or winPos[1],
		border = "rounded",

	}
	return vim.api.nvim_open_win(buf, true, opts)
end



function OpenWindow(width, height, content, pos, bg, fg, func, funcArgs, row, col, opts)
	local buf = createPopupBuffer()
	content = content or { "" }
	width = width or 50
	height = height or 10
	local win = createPopupWindow(buf, width, height, row, col, opts, pos)

	-- Set buffer options
	vim.api.nvim_buf_set_option(buf, "filetype", "lua") -- Safer filetype
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")

	-- Close window with 'q'
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<CR>", {
		noremap = true,
		silent = true,
	})

	-- Parse HTML content before displaying
	local parsedLines, highlights = parseHTMLContent(content, buf)

	-- Set buffer content
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, parsedLines)

	-- Apply highlights
	for _, hl in ipairs(highlights) do
		vim.api.nvim_buf_add_highlight(buf, -1, hl[1], hl[2], hl[3], hl[4])
	end

	-- Run optional function
	if func then
		if funcArgs then
			func(table.unpack(funcArgs))
		else
			func()
		end
	end

	-- Set background & text color
	local bg_group = "PopupBackground"
	vim.cmd(string.format("highlight %s guibg=%s", bg_group, bg or "None"))

	local text_group = "PopupTextHighlight"
	vim.cmd(string.format("highlight %s guibg=%s guifg=%s", text_group, bg or "None", fg or "None"))

	vim.api.nvim_win_set_option(win, "winhl", "Normal:" .. bg_group)

	return { buf = buf, win = win }
end

return { OpenWindow }
