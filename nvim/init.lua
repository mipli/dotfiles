local o = vim.o
local w = vim.wo
local b = vim.bo

local utils = require('utils')

vim.g.mapleader = ','

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

if o.shell == 'fish$' then
  o.shell = [[/bin/bash]]
end

o.completeopt = [[menuone,noinsert,noselect]]

-- Nice menu when typing `:find *.py`
o.wildmode = [[longest,list,full]]
o.wildmenu = true
-- Ignore files
o.wildignore=[[*.pyc,**/coverage/*,**/node_modules/*,**/.git/*]]

-- General mappings, not depending on any plugins
utils.map('n', 'Q', '<nop>', {noremap = true})
utils.map('n', ';', ':', {noremap = true})

utils.map('v', 'J', [[:m '>+1<cr>gv=gv]], {noremap = true})
utils.map('v', 'J', [[:m '>+1<cr>gv=gv]], {noremap = true})
utils.map('v', 'K', [[:m '<-2<cr>gv=gv]], {noremap = true})

utils.map('n', '<Tab>', ':tabnext<cr>', {noremap = true})
utils.map('n', '<S-Tab>', ':tabprev<cr>', {noremap = true})

utils.create_augroup({
  {'FileType', '*', 'setlocal', 'shiftwidth=4'},
  {'FileType', 'lua', 'setlocal', 'shiftwidth=2'},
  {'BufNewFile,BufReadPost', '*.md', 'set', 'filetype=markdown'},
}, 'Base')

require('plugins')
require('statusline')
require('lsp')
require('lspkind').init()
require('mappings')
require('gitsigns-config')
require('telescope-config')
require('treesitter-config')

vim.cmd [[let $NVIM_TUI_ENABLE_TRUE_COLOR=1]]
vim.cmd [[let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1]]

vim.cmd [[colorscheme nord]]
vim.cmd [[set background=dark]]
