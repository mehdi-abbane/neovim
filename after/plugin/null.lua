-- Require and setup lsp-format
require('lsp-format').setup({
	sync = false, -- Enable synchronous formatting (default: false)
	async = true, -- Enable asynchronous formatting (default: true)
	quiet = false, -- Suppress formatting warnings (default: false)
})

-- Attach lsp-format to LSP clients
local on_attach = function(client, bufnr)
	require('lsp-format').on_attach(client, bufnr)
end

-- Configure LSP servers
local lspconfig = require('lspconfig')

-- Lua (using stylua)
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
				},
			},
		},
	},
})

-- JavaScript/TypeScript (using Prettier)
lspconfig.ts_ls.setup({
	on_attach = on_attach,
})

-- C/C++ (using clang-format)
lspconfig.clangd.setup({
	on_attach = on_attach,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.php",
	callback = function()
		vim.lsp.buf.format({ async = false }) -- Format the file before saving
	end,
})
-- Keybinding for Shift + F to format the document
vim.keymap.set('n', '<S-F>', function()
	vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true })
