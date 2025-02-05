vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Package Manager
	use("wbthomason/packer.nvim")

	-- UI Enhancements
	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	})
	use({ "glepnir/galaxyline.nvim", branch = "main", requires = { "nvim-tree/nvim-web-devicons" } })

	-- File Navigation
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup()
		end,
	})

	-- Syntax & Treesitter
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- LSP & Formatting
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use("lukas-reineke/lsp-format.nvim")
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- Rust Support
	use("simrat39/rust-tools.nvim")

	-- Autocompletion & Snippets
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "L3MON4D3/LuaSnip" })

	-- Debugging
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
	})

	-- Testing
	use({ "nvim-neotest/nvim-nio" })
end)

