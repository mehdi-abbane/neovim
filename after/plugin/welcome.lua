local welcome_messages = {
	"      Welcome aboard!",
	"      Hello, boss!",
	"       Glad to see you!",
	"       Let's get productive!",
	"       Neovim is ready!",
	"       Coding time!",
	{ "          Make something", "           great today!" },
}
local function get_random_welcome()
	math.randomseed(os.time()) -- Seed the random generator
	return welcome_messages[math.random(#welcome_messages)]
end
local msg = get_random_welcome()
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local window = OpenWindow(30, 4, { msg }, "center")
		vim.defer_fn(function()
			vim.api.nvim_win_close(window.win, true)
		end, 2000)
	end
})
