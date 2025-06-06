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
		--PHP

		null_ls.builtins.formatting.phpcsfixer,

		--BASH
		null_ls.builtins.formatting.shfmt,
	},
})
