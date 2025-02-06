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

local function setKeymaps(buf, win, doFunc, args)
	doFunc()
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



local function flattenAndConvertToStrings(tbl)
	local result = {}
	for _, value in ipairs(tbl) do
		if type(value) == "table" then
			-- Recursively flatten any nested table
			for _, v in ipairs(flattenAndConvertToStrings(value)) do
				table.insert(result, tostring(v)) -- Convert and flatten nested elements
			end
		else
			table.insert(result, tostring(value)) -- Convert non-table values to string
		end
	end
	return result
end

-- Now use the function to process 'content'
function OpenWindow(width, height, content, pos, func, funcArgs, row, col, opts)
	local buf = createPopupBuffer()
	content = content or { "" }
	width = width or 50
	height = height or 10
	local win = createPopupWindow(buf, width, height, row, col, opts, pos)
	vim.api.nvim_buf_set_option(buf, "filetype", "Normal")
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<CR>", {
		noremap = true,
		silent = true,
	})
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")

	if type(content) == "table" then
		local tbContent = flattenAndConvertToStrings(content)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, tbContent)
	else
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { tostring(content) })
	end
	-- Helper function to flatten and convert everything into a string
	if (func ~= nil) then
		if (funcArgs ~= nil) then
			funcArgs = table.unpack(funcArgs) or {}
			func(funcArgs)
		end
		if (funcArgs == nil) then
			func()
		end
	end
	local window = {
		buf = buf,
		win = win
	}
	return window
end

return

{ OpenWindow }
