vim.cmd [[packadd packer.nvim]]

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'editorconfig/editorconfig-vim'

    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    use {
      'nvim-telescope/telescope-media-files.nvim',
      requires = {'nvim-telescope/telescope.nvim'}
    }

    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {"lukas-reineke/indent-blankline.nvim"}

    use 'tjdevries/express_line.nvim'
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'vim-autoformat/vim-autoformat'

    use 'folke/tokyonight.nvim'
    use 'norcalli/nvim-colorizer.lua'

    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'onsails/lspkind-nvim'
    use "nvim-treesitter/nvim-treesitter"
    use "terrortylor/nvim-comment"

    use 'simrat39/rust-tools.nvim'
  end,
  config = {
    display = {
      _open_fn = function(name)
	-- Can only use plenary when we have our plugins.
	--  We can only get plenary when we don't have our plugins ;)
	local ok, float_win = pcall(function()
	  return
	  require('plenary.window.float').percentage_range_window(
	  0.8, 0.8)
	end)

	if not ok then
	  vim.cmd [[65vnew  [packer] ]]
	  return vim.api.nvim_get_current_win(),
	  vim.api.nvim_get_current_buf()
	end

	local bufnr = float_win.buf
	local win = float_win.win

	vim.api.nvim_buf_set_name(bufnr, name)
	vim.api.nvim_win_set_option(win, 'winblend', 10)

	return win, bufnr
      end
    }
  }
})
