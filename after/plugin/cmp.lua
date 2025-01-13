local cmp = require("cmp")
local luasnip = require("luasnip")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("luasnip.loaders.from_vscode").lazy_load()
local function setup_cmp()
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- Use luasnip for snippet expansion
			end,
		},
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item(), -- Next item
			["<C-p>"] = cmp.mapping.select_prev_item(), -- Previous item
			["<C-d>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
			["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentation down
			["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
			["<C-e>"] = cmp.mapping.abort(), -- Close completion menu
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" }, -- LSP completions
			{ name = "luasnip" }, -- Snippets
		}, {
			{ name = "buffer", max_item_count = 1 }, -- Buffer completions
			{ name = "path" }, -- File path completions
		}),
	})
end
local function setup_cmdline_cmp()
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "path" },
			{ name = "cmdline" },
		},
	})
end
local function setup_search_cmp()
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})
end
local function setup_lsp()
	local servers = { "clangd", "omnisharp", "lua_ls", "ts_ls" }

	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				-- LSP keymaps
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			end,
		})
	end
end
setup_cmp()
setup_cmdline_cmp()
setup_search_cmp()
setup_lsp()
