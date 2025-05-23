local palettes = {
	tokyonight = {
		Bold          = "gui=bold",
		Italic        = "gui=italic",
		Underline     = "gui=underline",
		Color0        = "guifg=#c0caf5",
		Header1       = "guifg=#bb9af7 gui=bold",
		Header2       = "guifg=#7aa2f7 gui=bold",
		Header3       = "guifg=#9ece6a gui=bold",
		Paragraph     = "guifg=#a9b1d6",
		Blockquote    = "guifg=#7aa2f7 gui=italic",
		Link          = "guifg=#7aa2f7 gui=underline",
		List          = "gui=bold",
		Code          = "gui=italic guibg=#1a1b26",
		Hr            = "guifg=#565f89",
		Strikethrough = "gui=strikethrough",
	},

	monokai = {
		Bold          = "gui=bold",
		Italic        = "gui=italic",
		Underline     = "gui=underline",
		Color0        = "guifg=#f8f8f2",
		Header1       = "guifg=#f92672 gui=bold",
		Header2       = "guifg=#a6e22e gui=bold",
		Header3       = "guifg=#fd971f gui=bold",
		Paragraph     = "guifg=#f8f8f2",
		Blockquote    = "guifg=#75715e",
		Link          = "guifg=#66d9ef gui=underline",
		List          = "gui=bold",
		Code          = "gui=italic guibg=#272822",
		Hr            = "guifg=#f8f8f2",
		Strikethrough = "gui=strikethrough",
	},

	["rose-pine"] = {
		Bold          = "gui=bold",
		Italic        = "gui=italic",
		Underline     = "gui=underline",
		Color0        = "guifg=#e0def4",
		Header1       = "guifg=#eb6f92 gui=bold",
		Header2       = "guifg=#f6c177 gui=bold",
		Header3       = "guifg=#ebb3b3 gui=bold",
		Paragraph     = "guifg=#d4c6b0",
		Blockquote    = "guifg=#9ccfd8 gui=italic",
		Link          = "guifg=#ebbcba gui=underline",
		List          = "gui=bold",
		Code          = "gui=italic guibg=#191724",
		Hr            = "guifg=#6e6a86",
		Strikethrough = "gui=strikethrough",
	},
	["solorized-osaka"] = {
		Bold          = "gui=bold",
		Italic        = "gui=italic",
		Underline     = "gui=underline",
		Color0        = "guifg=#839496",
		Header1       = "guifg=#268bd2 gui=bold",
		Header2       = "guifg=#2aa198 gui=bold",
		Header3       = "guifg=#b58900 gui=bold",
		Paragraph     = "guifg=#657b83",
		Blockquote    = "guifg=#93a1a1 gui=italic",
		Link          = "guifg=#268bd2 gui=underline",
		List          = "gui=bold",
		Code          = "gui=italic guibg=#073642",
		Hr            = "guifg=#586e75",
		Strikethrough = "gui=strikethrough",
	},
	gruvbox = {
		Bold          = "gui=bold",
		Italic        = "gui=italic",
		Underline     = "gui=underline",
		Color0        = "guifg=#ebdbb2",
		Header1       = "guifg=#fb4934 gui=bold",
		Header2       = "guifg=#b8bb26 gui=bold",
		Header3       = "guifg=#fabd2f gui=bold",
		Paragraph     = "guifg=#ebdbb2",
		Blockquote    = "guifg=#83a598",
		Link          = "guifg=#83a598 gui=underline",
		List          = "gui=bold",
		Code          = "gui=italic guibg=#3c3836",
		Hr            = "guifg=#928374",
		Strikethrough = "gui=strikethrough",
	},
}

local function createPopupBuffer()
	return vim.api.nvim_create_buf(false, true)
end

local function calculateWindowPosition(width, height, position)
	local ui = vim.api.nvim_list_uis()[1]
	local screen_width, screen_height = ui.width, ui.height
	local positions = {
		top_left      = { 0, 0 },
		top_center    = { (screen_width - width) / 2, 0 },
		top_right     = { screen_width - width, 0 },
		bottom_left   = { 0, screen_height - height },
		bottom_center = { (screen_width - width) / 2, screen_height - height },
		bottom_right  = { screen_width - width, screen_height - height },
		left_center   = { 0, (screen_height - height) / 2 },
		right_center  = { screen_width - width, (screen_height - height) / 2 },
		center        = { (screen_width - width) / 2, (screen_height - height) / 2 },
	}
	return positions[position] or positions.top_left
end

local function createPopupWindow(buf, width, height, row, col, opts, pos)
	local win_pos = calculateWindowPosition(width, height, pos)
	opts = opts or {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row or win_pos[2],
		col = col or win_pos[1],
		border = "single",
	}
	return vim.api.nvim_open_win(buf, true, opts)
end

function SetOptionsToWindow(buf, win)
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<CR>", {
		noremap = true,
		silent = true,
	})
	vim.api.nvim_win_set_option(win, "wrap", true)
	vim.api.nvim_win_set_option(win, "linebreak", true)
end

function ProcessContent(content, width, buf)
	local in_ol = false
	local ol_counter = 0
	local highlights = {
		-- Basic text formatting
		{ "<b>(.-)</b>",                   "Bold" },
		{ "<i>(.-)</i>",                   "Italic" },
		{ "<u>(.-)</u>",                   "Underline" },
		{ "<color:#(.-)>(.-)</color>",     "Color" },
		{ "<h1>(.-)</h1>",                 "Header1" },
		{ "<h2>(.-)</h2>",                 "Header2" },
		{ "<h3>(.-)</h3>",                 "Header3" },
		{ "<p>(.-)</p>",                   "Paragraph" },
		{ "<blockquote>(.-)</blockquote>", "Blockquote" },
		{ '<a href="(.-)">(.-)</a>',       "Link" },
		{ "<li>(.-)</li>",                 "List" },
		{ "<code>(.-)</code>",             "Code" },
		{ "<hr>",                          "Hr" },
		{ "<strike>(.-)</strike>",         "Strikethrough" },
		{ "<del>(.-)</del>",               "Strikethrough" },
	}
	local clean_content = {}
	local highlight_data = {}
	for line_idx, orig_line in ipairs(content) do
		local line = orig_line
		if line:find("<ol>") then
			in_ol = true
			ol_counter = 1
			line = line:gsub("<ol>", "")
		end
		if line:find("</ol>") then
			in_ol = false
			line = line:gsub("</ol>", "")
		end
		line = line:gsub("<ul>", ""):gsub("</ul>", "")
		local matches = {}
		for _, hl in ipairs(highlights) do
			local pattern, hl_group = hl[1], hl[2]

			line = line:gsub(pattern, function(...)
				local args = { ... }
				local text, extra

				if hl_group == "Color" then
					extra = args[1]
					text = args[2]
				elseif hl_group == "List" then
					if in_ol then
						text = ol_counter .. ". " .. args[1]
						ol_counter = ol_counter + 1
					else
						text = "• " .. args[1]
					end
				elseif hl_group == "Hr" then
					text = string.rep("─", width)
				elseif hl_group == "LineBreak" then
					text = "\n"
				elseif hl_group == "Blockquote" then
					text = "> " .. args[1]
				elseif hl_group == "Link" then
					extra = args[1]
					text = args[2]
				else
					text = args[1]
				end
				if hl_group ~= "LineBreak" then
					table.insert(matches, {
						text = text,
						hl_group = hl_group,
						hex = extra,
						url = (hl_group == "Link") and extra or nil,
					})
				end

				return text
			end)
		end
		for _, match in ipairs(matches) do
			local start_pos = line:find(match.text, 1, true)
			if start_pos then
				table.insert(highlight_data, {
					line_idx = line_idx - 1,
					start_col = start_pos - 1,
					end_col = start_pos + #match.text - 1,
					hl_group = match.hl_group,
					hex = match.hex,
					url = match.url,
				})
			end
		end

		table.insert(clean_content, line)
	end
	return clean_content, highlight_data
end

function DoFunction(func, args)
	if func then
		if args then
			func(table.unpack(args))
		else
			func()
		end
	end
end

function ApplyHighlights(highlight_data, buf, palette)
	local selected_palette = palettes[palette] or palettes['tokyonight']
	for group, settings in pairs(selected_palette) do
		vim.cmd("highlight " .. group .. " " .. settings)
	end
	for _, hl in ipairs(highlight_data) do
		if hl.hl_group == "Color" and hl.hex then
			local color_hl = "Color" .. hl.hex
			vim.cmd("highlight " .. color_hl .. " guifg=#" .. hl.hex)
			hl.hl_group = color_hl
		end
		vim.api.nvim_buf_add_highlight(buf, -1, hl.hl_group, hl.line_idx, hl.start_col, hl.end_col)
	end
end

function OpenWindow(width, height, content, pos, palette, func, funcArgs, row, col, opts)
	local buf = createPopupBuffer()
	width = width or 50
	height = height or 10
	local win = createPopupWindow(buf, width, height, row, col, opts, pos)
	local clean_content, highlight_data = ProcessContent(content, width)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, clean_content)
	ApplyHighlights(highlight_data, buf, palette)
	SetOptionsToWindow(buf, win)
	DoFunction(func, funcArgs)
	return { buf = buf, win = win }
end

return { OpenWindow }
