local o = vim.o
local w = vim.wo
local b = vim.bo

local utils = require('utils')

vim.g.mapleader = ' '

b.autoindent = true
b.expandtab = true
b.softtabstop = 4
b.shiftwidth = 4
b.tabstop = 4
b.smartindent = true
b.modeline = false

o.backspace = [[indent,eol,start]]
o.hidden = true
w.winfixwidth = true

o.lazyredraw = true

o.splitbelow = true
o.splitright = true

b.synmaxcol = 4000

w.number = true
w.relativenumber = true

w.list = true
if vim.fn.has('multi_byte') == 1 and vim.o.encoding == 'utf-8' then
  o.listchars = [[tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:…]]
else
  o.listchars = [[tab:> ,extends:>,precedes:<,nbsp:.,trail:_]]
end

w.colorcolumn = [[100]]
w.wrap = false
w.signcolumn = "yes:1"

o.termguicolors = true

o.clipboard = [[unnamed,unnamedplus]]

o.scrolloff = 4

o.timeoutlen = 300

o.mouse = 'a'

w.foldmethod = 'expr'
w.foldexpr = [[nvim_treesitter#foldexpr()]]
w.foldlevel = 2

if o.shell == 'fish$' then o.shell = [[/bin/bash]] end

o.completeopt = [[menuone,noinsert,noselect]]

-- Nice menu when typing `:find *.py`
o.wildmode = [[longest,list,full]]
o.wildmenu = true
-- Ignore files
o.wildignore = [[*.pyc,**/coverage/*,**/node_modules/*,**/.git/*]]

require('plugins')
require('statusline')
require('lsp')
require('lspkind').init()
require('mappings')
require('gitsigns-config')
require('telescope-config')
require('treesitter-config')
require('autoformat-config')
require('colorizer').setup()
require('nvim_comment').setup()
require('dart')

vim.cmd [[let $NVIM_TUI_ENABLE_TRUE_COLOR=1]]
vim.cmd [[let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1]]

vim.cmd [[set background=dark]]
vim.cmd [[colorscheme tokyonight]]

utils.create_augroup({
  {'FileType', '*', 'setlocal', 'shiftwidth=4'},
  {'FileType', 'lua', 'setlocal', 'shiftwidth=2'},
  {'BufNewFile,BufReadPost', '*.md', 'set', 'filetype=markdown'}
}, 'Base')
