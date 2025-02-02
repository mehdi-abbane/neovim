require("mason").setup({
	ui = {
		border = "single",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Define on_attach function for keybindings
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

-- Configure LSP servers
local servers = { "clangd", "lua_ls", "ts_ls", "html", "cssls", "omnisharp", "intelephense" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
require("lspconfig").omnisharp.setup({
	cmd = { "omnisharp", "--hostPID", tostring(vim.fn.getpid()), "--encoding", "utf-8", "--languageserver" },
})
