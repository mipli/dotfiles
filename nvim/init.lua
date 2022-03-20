local utils = require("utils")

vim.g.mapleader = " "

vim.opt.laststatus = 3

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.modeline = false

vim.opt.inccommand = "split"
vim.opt.backspace = [[indent,eol,start]]
vim.opt.hidden = true
vim.opt.winfixwidth = true

vim.opt.lazyredraw = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.synmaxcol = 4000

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.list = true
vim.opt.listchars = [[tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:…]]

vim.opt.colorcolumn = [[100]]
vim.opt.wrap = false
vim.opt.signcolumn = "yes:1"

vim.opt.termguicolors = true

vim.opt.clipboard = [[unnamed,unnamedplus]]

vim.opt.scrolloff = 4

vim.opt.timeoutlen = 300

vim.opt.mouse = "a"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = [[nvim_treesitter#foldexpr()]]
vim.opt.foldlevel = 2

if vim.opt.shell == "fish$" then
	vim.opt.shell = [[/bin/bash]]
end

vim.opt.completeopt = [[menuone,noinsert,noselect]]
vim.opt.shortmess = vim.o.shortmess .. "c"

-- Nice menu when typing `:find *.py`
vim.opt.wildmode = [[longest,list,full]]
vim.opt.wildmenu = true
-- Ignore files
vim.opt.wildignore = [[*.pyc,**/coverage/*,**/node_modules/*,**/.git/*]]

require("plugins")
-- require('statusline')
require("lsp_conf")
require("cmp_conf")
require("lspkind").init()
require("mappings")
require("gitsigns-config")
require("telescope-config")
require("treesitter-config")
require("colorizer").setup()
require("nvim_comment").setup()
require("trouble").setup({
	use_diagnostic_signs = true,
})
require("dart")
require("lualine").setup({
	options = {
		-- ... your lualine config
		theme = "nightfox",
	},
})
require("wk_conf")

require("indent_blankline").setup({
	show_end_of_line = true,
	show_current_context = true,
	show_current_context_start = true,
})

vim.cmd([[let $NVIM_TUI_ENABLE_TRUE_COLOR=1]])
vim.cmd([[let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1]])

vim.cmd([[set background=dark]])
vim.cmd([[colorscheme kanagawa]])

utils.create_augroup({
	{ "BufNewFile,BufReadPost", "*.md", "set", "filetype=markdown" },
}, "Base")
