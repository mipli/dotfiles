" Setup dein  ---------------------------------------------------------------{{{
  if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
  endif

  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
  call dein#begin(expand('~/.config/nvim'))
  call dein#add('Shougo/dein.vim')

  " themes
  call dein#add('morhetz/gruvbox')

  " airline
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')

  call dein#add('editorconfig/editorconfig-vim')

  call dein#add('benmills/vimux')
  call dein#add('jpalardy/vim-slime')

  call dein#add('autozimu/LanguageClient-neovim', { 'rev': 'next', 'build': 'bash install.sh', })

  call dein#add('w0rp/ale')

  " Rust 
  call dein#add('rust-lang/rust.vim')

  " Javascript
  call dein#add('pangloss/vim-javascript')

  " PHP
  call dein#add('roxma/LanguageServer-php-neovim',  { 'rev': 'master', 'build': 'composer install && composer run-script parse-stubs'})

  " enable deoplete
  let g:deoplete#enable_at_startup = 1

  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif

  call dein#end()
  call dein#save_state()
  filetype plugin indent on
" }}}

" System setup  -------------------------------------------------------------{{{
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

  set nowrap

  set signcolumn=yes

  set virtualedit=
  set wildmenu
  set laststatus=2
  set wrap linebreak 
  set wildmode=full

  " Tell Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines. VERY useful!
  " set listchars=tab:>-,trail:·,extends:>,precedes:<,nbsp:+
  " set listchars=tab:»·,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·
  set listchars=tab:»\ ,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·
  set list                " Show problematic characters.

  " Also highlight all tabs and trailing whitespace characters.
  highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  match ExtraWhitespace /\s\+$\|\t/

  set undofile
  set undodir="$HOME/.nvim/undo"

  set ignorecase
  set incsearch
  set smartcase
  set hlsearch!

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
  " set complete=.,w,b,u,t,k
  let g:gitgutter_max_signs = 1001  " default value
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  let g:indentLine_char='│'

  set splitbelow
  set splitright

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

" vim-airline ---------------------------------------------------------------{{{
  let g:airline#extensions#tabline#enabled = 1
  set hidden
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
  call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>',
        \'noremap')
  call denite#custom#map('normal', '<Esc>', '<NOP>',
        \'noremap')
  call denite#custom#map('normal', '<Esc>', '<NOP>',
        \'noremap')
  call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>',
        \'noremap')
  call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>',
        \'noremap')
  call denite#custom#map('insert', '<C-h>', '<denite:do_action:split>',
        \'noremap')
  call denite#custom#map('normal', '<C-h>', '<denite:do_action:split>',
        \'noremap')


  nnoremap <C-p> :<C-u>Denite file_rec<CR>
  nnoremap <leader>s :<C-u>Denite buffer<CR>
  nnoremap <leader><Space>s :<C-u>DeniteBufferDir buffer<CR>
  nnoremap <leader>8 :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
  nnoremap <leader>/ :<C-u>Denite grep<CR>
  nnoremap <leader><Space>/ :<C-u>DeniteBufferDir grep:. -mode=normal<CR>
  nnoremap <leader>d :<C-u>DeniteBufferDir file_rec<CR>
  nnoremap <leader>o :Denite outline<CR>
"}}}

" Deoplete -----------------------------------------------------{{{
let g:deoplete#enable_at_startup=1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#auto_complete_delay = 50
" }}}

" Language Server Setup -----------------------------------------------------{{{
" " Required for operations modifying multiple buffers like rename.
"
set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_changeThrottle = 0.5
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'php': ['php', expand('~/.config/nvim/repos/github.com/roxma/LanguageServer-php-neovim/vendor/felixfbecker/language-server/bin/php-language-server.php')]
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" }}}


" Rust -------------------------------------------------------------------{{{
"
let g:autofmt_autosave = 1 
" }}}


" Linting -------------------------------------------------------------------{{{
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1

nmap <silent> <C-q> <Plug>(ale_next_wrap)
"}}}

" Tmux --------------------------------------{{{
if (!empty($TMUX))
  let g:slime_target = "tmux"
  let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
  let g:slime_python_ipython = 1
endif
"}}}
"

  " call dein#add('plasticboy/vim-markdown')
  " call dein#add('Shougo/deoplete.nvim')
  " call dein#add('Shougo/unite.vim')
  " call dein#add('Shougo/unite-outline')
  "call dein#add('mhartington/deoplete-typescript')
  "call dein#add('carlitux/deoplete-ternjs')

  "call dein#add('Shougo/neomru.vim')

  " call dein#add('ujihisa/unite-colorscheme')
  " call dein#add('junkblocker/unite-codesearch')
  " call dein#add('rafi/vim-unite-issue')

  "call dein#add('tpope/vim-fugitive')
  "call dein#add('tpope/vim-dispatch')

  " call dein#add('neomake/neomake')

  " call dein#add('nvie/vim-flake8')
  " call dein#add('zchee/deoplete-jedi')
  " call dein#add('davidhalter/jedi')
  " call dein#add('tmhedberg/SimpylFold')

  " call dein#add('OmniSharp/omnisharp-vim')
  " call dein#add('tpope/vim-dispatch')
  " call dein#add('radenling/vim-dispatch-neovim')

  " call dein#add('chrisbra/csv.vim')

  " call dein#add('bfredl/nvim-ipy')

