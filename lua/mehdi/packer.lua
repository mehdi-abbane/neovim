vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({ "ellisonleao/gruvbox.nvim" })
	use({ 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' })
	use({ 'mg979/vim-visual-multi' })
	use({ 'windwp/nvim-ts-autotag' })
	use({ "rose-pine/neovim" })
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', }
	}
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "L3MON4D3/LuaSnip" })
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
	})
	use({ "nvim-neotest/nvim-nio" })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({ "ThePrimeagen/harpoon" })
	use({ "craftzdog/solarized-osaka.nvim" })
	use({ 'Abstract-IDE/Abstract-cs' })
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use({
		"tpope/vim-dadbod",       -- Database interaction
		"kristijanhusak/vim-dadbod-ui", -- UI for managing databases
		"kristijanhusak/vim-dadbod-completion", -- Autocompletion for SQL
	})
end)
