require('nvim-ts-autotag').setup()
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
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(client, bufnr)
	local bufmap = function(mode, lhs, rhs)
		vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
	end
	bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")   -- Go to definition
	bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")   -- Show references
	bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")         -- Hover info
	bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>") -- Rename symbol
	bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>") -- Code actions
	bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>") -- Previous diagnostic
	bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>") -- Next diagnostic
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end
end


local util = require("lspconfig.util")

local omnisharp_bin = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp"

lspconfig.omnisharp.setup({
	on_attach = on_attach,

	capabilities = capabilities,
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
	root_dir = util.root_pattern("*.sln", "*.csproj", ".git"),
	enable_roslyn_analyzers = true,
	organize_imports_on_format = true,
	enable_import_completion = true,
})



lspconfig.clangd.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
})
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {

		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = {
				command = "clippy",
			},
		},
	},
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
-- lspconfig.omnisharp.setup({
-- 	cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
-- 	capabilities = capabilities,
-- })
lspconfig.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
})
lspconfig.vls.setup {
	cmd = { "vls", "--stdio" },
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "vue" },
	root_dir = require 'lspconfig'.util.root_pattern("package.json", "tsconfig.json", ".git"),
	init_options = {
		config = {
			vetur = {
				completion = true,
				validation = true,
				formatting = true,
			}
		}
	},
}


lspconfig.intelephense.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		intelephense = {
			environment = {
				includePaths = { "./vendor" }
			},
			files = {
				maxSize = 5000000
			}
		}
	}
})
lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.html.setup({
	filetypes = { "html", "php", "blade", 'javascriptreact' },
	capabilities = capabilities,
})
lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	gopls = {
		usePlaceholders = true,
		completeUnimported = true,
		staticcheck = true,
	},
})
-- lspconfig.htmx.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
lspconfig.emmet_language_server.setup({
	filetypes    = { "html", "css", "javascript", "typescript", "vue", "php", "blade", "javascriptreact" },
	capabilities = capabilities
})

lspconfig.bashls.setup({
	filetypes = { "sh", 'bash' },
	on_attach = on_attach,
	capabilities = capabilities
})
lspconfig.pyright.setup({});
