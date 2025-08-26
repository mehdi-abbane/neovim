local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
	install_info = {
		url = "https://github.com/EmranMR/tree-sitter-blade",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "blade",
}
vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})
require 'nvim-treesitter.configs'.setup {

	-- ensure_installed = { "c", "lua", "javascript", "c_sharp", "typescript", "cpp", "css", "html", "php", "rust" },
	indent = { enable = false }, -- Disable Treesitter-based indentation guideo
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	folding = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["fa"] = "@function.outer", -- Select around a function
				["fi"] = "@function.inner", -- Select inner part of a function
			},
		},
	},
}
