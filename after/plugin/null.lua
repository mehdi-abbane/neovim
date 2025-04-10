local null_ls = require("null-ls")

-- Set up formatting with null-ls
null_ls.setup({
	sources = {
		-- Python (black)
		null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
		-- JavaScript/TypeScript (prettier)
		null_ls.builtins.formatting.prettier,
		-- C++ (clang-format)
		null_ls.builtins.formatting.clang_format,
		-- CSS (prettier)
		null_ls.builtins.formatting.rustfmt,
		--PHP
		null_ls.builtins.formatting.phpcsfixer
	},
})

-- Format on save
-- Format on demand with a keybinding (e.g., <leader>f)
vim.api.nvim_set_keymap('n', '<S-f>', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
