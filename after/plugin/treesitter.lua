require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "javascript", "c_sharp", "typescript", "cpp", "css", "html", "php", "rust" },
	sync_install = false,
	ignore_install = { "" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
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
