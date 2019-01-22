" Setup dein  ---------------------------------------------------------------{{{
if &compatible
  set nocompatible
endif

set runtimepath+=/home/michael/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/michael/.cache/dein')
  call dein#begin('/home/michael/.cache/dein')

  call dein#add('/home/michael/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('morhetz/gruvbox')

  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')

  " call dein#add('tpope/vim-fugitive')

  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('sgur/vim-editorconfig')

  call dein#add('tpope/vim-fugitive')

  call dein#add('majutsushi/tagbar')
  call dein#add('airblade/vim-gitgutter')

  call dein#add('w0rp/ale')

  call dein#add('autozimu/LanguageClient-neovim', {
        \ 'rev': 'next',
        \ 'build': 'bash install.sh',
        \ })

  call dein#add('othree/yajs.vim')

  call dein#add('benmills/vimux')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" }}}

" Mappings  -----------------------------------------------------------------{{{
  let mapleader = ','
" No need for ex mode
  nnoremap Q <nop>
  nnoremap ; :

  vmap < <gv
  vmap > >gv

  " change buffer
  map <C-l> :bn<Cr>
  map <C-h> :bp<Cr>

  nmap <c-[> <esc>
  imap <c-[> <esc>
  vmap <c-[> <esc>
  omap <c-[> <esc>

  nmap <Leader>ln :lnext<CR>
  nmap <Leader>lp :lprev<CR>

  " tab navigation 
  nnoremap <S-tab> :tabprev<CR>
  nnoremap <tab> :tabnext<CR>
  nnoremap <C-C> :tabclose<CR>
  nnoremap <C-t> :tabnew<CR>
  inoremap <C-t> <Esc>:tabnew<CR>

  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  " vimux mappings
  map <Leader>vp :VimuxPromptCommand<CR>
  map <Leader>vl :VimuxRunLastCommand<CR>
  map <Leader>vz :VimuxZoomRunner<CR>

  " gitgutter mappings
  map <Leader>gj :GitGutterNextHunk<CR>
  map <Leader>gk :GitGutterPrevHunk<CR>

  " dp/do to get/put buffer when using :Gdiff
  autocmd BufRead fugitive\:* xnoremap <buffer> dp :diffput<cr>|xnoremap <buffer> do :diffget<cr>

" }}}

" System setup  -------------------------------------------------------------{{{
"
  set clipboard+=unnamedplus
  set pastetoggle=<f6>
  set nopaste

  set noshowmode
  set noswapfile
  filetype on
  set relativenumber number
  set tabstop=2 shiftwidth=2 expandtab
  set conceallevel=0
  set scrolloff=10

  set synmaxcol=800

  set nowrap

  set signcolumn=yes

  set virtualedit=
  set wildmenu
  set laststatus=2
  set wrap linebreak 
  set wildmode=full

  " Tell Vim which characters to show for expanded TABs,
  set listchars=tab:»\ ,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·
  set list                " Show problematic characters.

  set completeopt-=preview

  " Also highlight all tabs and trailing whitespace characters.
  highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  match ExtraWhitespace /\s\+$\|\t/

  set undofile
  set undodir="$HOME/.nvim/undo"

  set ignorecase
  set incsearch
  set smartcase
  set hlsearch!

  set hidden

" Let airline tell me my status
  set noshowmode
  set noswapfile

" Remember cursor position between vim sessions
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif
              " center buffer around cursor when opening files
  autocmd BufRead * normal zz

  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  let g:indentLine_char='│'
  let g:gitgutter_max_signs = 1001  " default value

  set splitbelow
  set splitright

" }}}

" Themes --------------------------------------------------------------------{{{
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  syntax enable
  " colorscheme
  let g:gruvbox_contrast_dark="hard"
  let g:gruvbox_contrast_light="hard"
  set background=dark
  colorscheme gruvbox

  " no need to fold things in markdown all the time
  let g:vim_markdown_folding_disabled = 1
  " turn on spelling for markdown files
  autocmd FileType markdown,text,html setlocal spell complete+=kspell
  " highlight bad words in red
  autocmd FileType markdown,text,html hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224
  " disable markdown auto-preview. Gets annoying
  let g:instant_markdown_autostart = 1

  " syntax highlight files based on folder
  autocmd BufRead,BufNewFile ~/.Xdefaults.d/* set filetype=xdefaults
"}}}

" Vim Airline ---------------------------------------------------------------{{{
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='gruvbox'
  cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
  tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
  nmap <leader>t :term<cr>
  nmap <leader>, :bnext<CR>
  tmap <leader>, <C-\><C-n>:bnext<cr>
  nmap <leader>. :bprevious<CR>
  tmap <leader>. <C-\><C-n>:bprevious<CR>
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
  tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
  tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
  tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
  tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
  tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
  tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
  tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
  tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
"}}}

" Folding -------------------------------------------------------------------{{{

  function! MyFoldText() " {{{
      let line = getline(v:foldstart)

      let nucolwidth = &fdc + &number * &numberwidth
      let windowwidth = winwidth(0) - nucolwidth - 3
      let foldedlinecount = v:foldend - v:foldstart

      " expand tabs into spaces
      let onetab = strpart('          ', 0, &tabstop)
      let line = substitute(line, '\t', onetab, 'g')

      let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
      let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
      return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
  endfunction " }}}

  set foldtext=MyFoldText()

  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

  autocmd FileType vim setlocal fdc=1
  set foldlevel=99
  " Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za

  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0

  autocmd FileType html,css,scss setlocal foldlevel=99
  autocmd FileType css,scss setlocal foldmethod=marker
  autocmd FileType css,scss setlocal foldmarker={,}

  autocmd FileType html setl foldmethod=syntax

  autocmd FileType javascript,typescript,json setl foldmethod=syntax
  autocmd FileType rust setl foldmethod=syntax
  autocmd FileType php setl foldmethod=syntax
" }}}

" Tagbar -----------------------------------------------------{{{
nmap <F8> :TagbarToggle<CR>

let g:tagbar_type_rust = {
      \ 'ctagstype' : 'rust',
      \ 'kinds' : [
      \'T:types,type definitions',
      \'f:functions,function definitions',
      \'g:enum,enumeration names',
      \'s:structure names',
      \'m:modules,module names',
      \'c:consts,static constants',
      \'t:traits',
      \'i:impls,trait implementations',
      \]
      \}
" }}}

" Deoplete -----------------------------------------------------{{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let b:deoplete_disable_auto_complete=1
let g:deoplete_disable_auto_complete=1

call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

call deoplete#custom#option('sources', {
            \ 'javascript': ['LanguageClient'],
            \ 'rust': ['LanguageClient'],
            \ 'vim': ['vim'],
            \})

" ignored sources
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'around']

" }}}

" Denite ---------------------------------------------------------------------{{{
    " reset 50% winheight on window resize
  augroup deniteresize
    autocmd!
    autocmd VimResized,VimEnter * call denite#custom#option('default',
          \'winheight', winheight(0) / 2)
  augroup end

  call denite#custom#option('default', {
        \ 'prompt': '❯'
        \ })

  call denite#custom#var('file_rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts',
        \ ['--hidden', '--vimgrep', '--no-heading', '-S'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>', 'noremap')
  call denite#custom#map('normal', '<Esc>', '<NOP>', 'noremap')
  call denite#custom#map('normal', '<Esc>', '<NOP>', 'noremap')
  call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
  call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
  call denite#custom#map('insert', '<C-h>', '<denite:do_action:split>', 'noremap')
  call denite#custom#map('normal', '<C-h>', '<denite:do_action:split>', 'noremap')
  call denite#custom#map('normal', '<C-q>', '<denite:quit>', 'noremap')


  nnoremap <C-p> :<C-u>Denite file_rec<CR>
  nnoremap <leader>s :<C-u>Denite buffer<CR>
  nnoremap <leader><Space>s :<C-u>DeniteBufferDir buffer<CR>
  nnoremap <leader>8 :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
  nnoremap <leader>/ :<C-u>Denite grep<CR>
  nnoremap <leader><Space>/ :<C-u>DeniteBufferDir grep:. -mode=normal<CR>
  nnoremap <leader>d :<C-u>DeniteBufferDir file_rec<CR>
  nnoremap <leader>o :Denite outline<CR>
"}}}

" Ale -------------------------------------------------------------------{{{
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_completion_enabled = 1

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'rust': ['rls'],
\}

nmap <silent> <C-q> <Plug>(ale_next_wrap)
"}}}

" Language Server Setup -----------------------------------------------------{{{
" " Required for operations modifying multiple buffers like rename.
"
set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_changeThrottle = 0.5
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ }
let g:LanguageClient_rootMarkers = {
      \ 'rust': ['Cargo.toml'],
      \ 'javascript': ['package.json'],
      \ }

set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> gf :call LanguageClient_textDocument_codeAction()<CR>

" }}}
