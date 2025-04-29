local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
local function setup_cmp()
	cmp.setup({
		window = {
			completion = {
				border = "rounded", -- Adds rounded border to completion menu
				winhighlight =
				"Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			},
			documentation = {
				border = "rounded", -- Adds rounded border to docs window
				winhighlight =
				"Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			},
		},
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
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer",  max_item_count = 1 },
			{ name = "path" },
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
setup_cmp()
setup_cmdline_cmp()
setup_search_cmp()
