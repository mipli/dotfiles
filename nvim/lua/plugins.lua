vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		use("simnalamburt/vim-mundo")

		use("editorconfig/editorconfig-vim")

		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		})
		use({
			"nvim-telescope/telescope-media-files.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
		})

		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
		use({ "lukas-reineke/indent-blankline.nvim" })

		use("tjdevries/express_line.nvim")
		use("ryanoasis/vim-devicons")
		use("kyazdani42/nvim-web-devicons")
		use("jose-elias-alvarez/null-ls.nvim")

		use("folke/which-key.nvim")

		use("folke/tokyonight.nvim")
		use("rebelot/kanagawa.nvim")
		use("EdenEast/nightfox.nvim")
		use("norcalli/nvim-colorizer.lua")

		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- enhancements in highlighting and virtual text
		use("terrortylor/nvim-comment")

		use("dart-lang/dart-vim-plugin")
		use("thosakwe/vim-flutter")

		use("neovim/nvim-lspconfig") -- Common LSP configurations
		use("nvim-lua/lsp-status.nvim") -- get status from lsp to show in status line
		use("onsails/lspkind-nvim") -- show pictograms in the auto complete popup

		use("hrsh7th/nvim-cmp") -- Completion framework
		use("hrsh7th/cmp-nvim-lsp") -- LSP completion source for nvim-cmp

		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		}) -- adds a bottom panel with lsp diagnostics, quickfixes, etc.

		use("hrsh7th/cmp-vsnip") -- Snippet completion source for nvim-cmp

		use("hrsh7th/cmp-path") -- Other usefull completion sources
		use("hrsh7th/cmp-buffer") -- Other usefull completion sources

		use("simrat39/rust-tools.nvim") -- To enable more of the features of rust-analyzer, such as inlay hints and more!

		use("hrsh7th/vim-vsnip") -- Snippet engine

		use({
			"folke/zen-mode.nvim",
			config = function()
				require("zen-mode").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})
	end,
	config = {
		display = {
			_open_fn = function(name)
				-- Can only use plenary when we have our plugins.
				--  We can only get plenary when we don't have our plugins ;)
				local ok, float_win = pcall(function()
					return require("plenary.window.float").percentage_range_window(0.8, 0.8)
				end)

				if not ok then
					vim.cmd([[65vnew  [packer] ]])
					return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
				end

				local bufnr = float_win.buf
				local win = float_win.win

				vim.api.nvim_buf_set_name(bufnr, name)
				vim.api.nvim_win_set_option(win, "winblend", 10)

				return win, bufnr
			end,
		},
	},
})
