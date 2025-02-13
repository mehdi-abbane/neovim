-- Mason UI settings
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

-- LSP Configuration
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Define on_attach function for keybindings
local on_attach = function(client, bufnr)
	local bufmap = function(mode, lhs, rhs)
		vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
	end

	-- Keybindings for LSP actions
	bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")   -- Go to definition
	bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")   -- Show references
	bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")         -- Hover info
	bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>") -- Rename symbol
	bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>") -- Code actions
	bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>") -- Previous diagnostic
	bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>") -- Next diagnostic

	-- Format on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end
end
lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = on_attach
})

-- CSS
lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.clangd.setup({
	capabilities = capabilities,
	cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
})
lspconfig.lua_ls.setup({
	capabilities = capabilities,

	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" }, -- Neovim uses LuaJIT
			diagnostics = {
				globals = { "vim" }, -- Prevent 'undefined global vim' warning
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- Recognize Neovim API
				checkThirdParty = false, -- Avoid annoying popups
			},
			telemetry = { enable = false }, -- Disable telemetry
		},
	},
})
lspconfig.pyright.setup({
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "basic", -- Change to "strict" for stricter linting
			},
		},
	},
})
lspconfig.omnisharp.setup({
	cmd = { "omnisharp", "--hostPID", tostring(vim.fn.getpid()), "--encoding", "utf-8", "--languageserver" },
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern("*.sln", ".git"),
	settings = {
		omnisharp = {
			useModernNet = true, -- Uses modern .NET versions
			enableRoslynAnalyzers = true,
			organizeImportsOnFormat = true,
		},
	},
})
lspconfig.ts_ls.setup({
	capabilities = capabilities,
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
})
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false }) -- Synchronous formatting
				end,
			})
		end
	end,
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = {
				command = "clippy" -- Use Clippy for linting
			},
		},
	},
})
