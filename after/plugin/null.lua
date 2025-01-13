local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- Formatter for C#
		null_ls.builtins.formatting.csharpier,
		-- Formatter for Lua
		null_ls.builtins.formatting.stylua,
		-- Formatter for C/C++
		null_ls.builtins.formatting.clang_format,
		-- Formatter for JS/TS/HTML/CSS
		null_ls.builtins.formatting.prettier,
	},
	on_attach = function(client, bufnr)
		-- Keymap for formatting
		local opts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "<S-F>", vim.lsp.buf.format, opts)
	end,
})
