-- Function to show a random motivational quote in a popup
function QuotingFunction(quotes)
	-- Ensure quotes are provided, fallback to default if not
	quotes = quotes or {
		"Believe in yourself and all that you are.",
		"The only way to do great work is to love what you do.",
		"Success is not final, failure is not fatal: It is the courage to continue that counts.",
		"Don't watch the clock; do what it does. Keep going.",
		"You are never too old to set another goal or to dream a new dream.",
		"The best way to predict the future is to create it.",
		"It always seems impossible until it’s done.",
		"Do not wait to strike till the iron is hot, but make it hot by striking.",
		"The future belongs to those who believe in the beauty of their dreams."
	}

	-- Ensure font is provided, fallback to default if not

	local quote = quotes[math.random(#quotes)]
	local content = {
		"               +------------------+               ",
		"               |Motivational Quote|               ",
		"               +------------------+               ",
		"      " .. quote .. "  ",
		"                                                  ",
		"                                                  ",
		"               +------------------+               ",
		"               |       by mhd     |               ",
		"               +------------------+               ",
	}

	local window = OpenWindow(width, height, content, "center")
	local buf = window.buf
	local win = window.win
	-- Set the font for the popup buffer
	vim.api.nvim_buf_set_option(buf, "filetype", "Normal")

	-- Keymap to close the popup
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<CR>", {
		noremap = true,
		silent = true,
	})

	-- Make the buffer non-editable
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
end

-- Return the function for external use

return {

	QuotingFunction = QuotingFunction
}
