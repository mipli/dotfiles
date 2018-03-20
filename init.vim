" Setup dein  ---------------------------------------------------------------{{{
  if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
  endif

  set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
  call dein#begin(expand('~/.config/nvim'))

  call dein#add('Shougo/dein.vim')
  call dein#add('ciaranm/detectindent')

  call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})
  call dein#add('othree/jsdoc-syntax.vim', {'on_ft':['javascript', 'typescript']})
  call dein#add('othree/es.next.syntax.vim', {'on_ft': 'javascript'})
  call dein#add('mxw/vim-jsx')
  call dein#add('ianks/vim-tsx')
  call dein#add('jaawerth/nrun.vim')
  call dein#add('posva/vim-vue')

  call dein#add('HerringtonDarkholme/yats.vim', {'on_ft': 'typescript'})

  call dein#add('moll/vim-node')

  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('mattn/emmet-vim', {'on_ft': 'html'})
  call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})

  call dein#add('Shougo/deoplete.nvim')
  " call dein#add('Shougo/unite.vim')
  " call dein#add('Shougo/unite-outline')

  call dein#add('Shougo/denite.nvim')

  call dein#add('mhartington/deoplete-typescript')
  call dein#add('carlitux/deoplete-ternjs')

  call dein#add('troydm/asyncfinder.vim')

  call dein#add('Shougo/neomru.vim')

  " call dein#add('ujihisa/unite-colorscheme')
  " call dein#add('junkblocker/unite-codesearch')
  " call dein#add('rafi/vim-unite-issue')

  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-dispatch')

  call dein#add('neomake/neomake')

  call dein#add('editorconfig/editorconfig-vim')

  call dein#add('nvie/vim-flake8')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('davidhalter/jedi')
  call dein#add('tmhedberg/SimpylFold')

  call dein#add('OmniSharp/omnisharp-vim')
  call dein#add('tpope/vim-dispatch')
  call dein#add('radenling/vim-dispatch-neovim')

  call dein#add('chrisbra/csv.vim')

  call dein#add('bfredl/nvim-ipy')

  call dein#add('benmills/vimux')
  call dein#add('jpalardy/vim-slime')

  call dein#add('rust-lang/rust.vim')

  call dein#add('plasticboy/vim-markdown')

  " enable deoplete
  let g:deoplete#enable_at_startup = 1

  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif

  call dein#end()
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
  let g:jsx_ext_required =0
  set complete=.,w,b,u,t,k
  let g:gitgutter_max_signs = 1000  " default value
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  let g:indentLine_char='│'

  set mouse=a

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

  nnoremap gb :ls<CR>:b<Space>

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

  syntax on
  set background=dark
  colorscheme lucius
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

  autocmd FileType html setlocal fdl=99

  autocmd FileType php,javascript,html,css,scss,typescript setlocal foldlevel=99
  autocmd FileType php,css,scss,json setlocal foldmethod=marker
  autocmd FileType php,css,scss,json setlocal foldmarker={,}

  autocmd FileType coffee setl foldmethod=indent
  autocmd FileType html setl foldmethod=syntax

  autocmd FileType javascript,typescript,json setl foldmethod=syntax

  autocmd FileType lua setlocal foldmethod=marker
" }}}

" vim-airline ---------------------------------------------------------------{{{
  let g:airline#extensions#tabline#enabled = 1
  set hidden
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='lucius'
  " let g:airline_theme='base16_solarized'
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

" Emmet ---------------------------------------------------------------------{{{
" Enable Emmet in all modes
" Remapping <C-y>, just doesn't cut it.
  function! s:expand_html_tab()
" try to determine if we're within quotes or tags.
" if so, assume we're in an emmet fill area.
   let line = getline('.')
   if col('.') < len(line)
     let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')
     if len(line) >= 2
        return "\<C-n>"
     endif
   endif
" expand anything emmet thinks is expandable.
  if emmet#isExpandable()
    return "\<C-y>,"
  endif
" return a regular tab character
  return "\<tab>"
  endfunction

  autocmd FileType html,markdown imap <buffer><expr><tab> <sid>expand_html_tab()
  let g:user_emmet_mode='a'
  let g:user_emmet_complete_tag = 0
  let g:user_emmet_install_global = 0
  autocmd FileType html,css EmmetInstall
"}}}

" Denite ---------------------------------------------------------------------{{{

  call denite#custom#option('default', 'prompt', '>')
  call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

  call denite#custom#map(
      \ 'insert',
      \ '<C-s>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
  call denite#custom#map(
      \ 'insert',
      \ '<C-w>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)


  nnoremap <silent> <leader>u :call dein#update()<CR>
  nnoremap <silent> <leader>m :Denite -auto-resize -direction=botright file_rec<CR>
  nnoremap <silent> <leader>o :Denite outline<CR>
"}}}

" Linting -------------------------------------------------------------------{{{
  function! EchoPWD()
    echom getcwd()
  endfunction

  let g:neomake_javascript_enabled_makers = ['eslint']
  function! neomake#makers#ft#javascript#eslint()
      return {
          \ 'args': ['-f', 'compact'],
          \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
          \ '%W%f: line %l\, col %c\, Warning - %m'
          \ }
  endfunction

"          \ '-m', 'commonjs', '-t', 'es5', '--noEmit', '--experimentalDecorators', '--emitDecoratorMetadata'
  function! neomake#makers#ft#typescript#tsc()
      return {
          \ 'args': [
          \ '--project', getcwd()
          \ ],
          \ 'append_file': 0,
          \ 'errorformat':
              \ '%E%f %#(%l\,%c): error %m,' .
              \ '%E%f %#(%l\,%c): %m,' .
              \ '%Eerror %m,' .
              \ '%C%\s%\+%m'
          \ }
  endfunction

  " you can set your enabled makers globally (like below) or on the buffer level as part of an autocmd - see Neomake docs for details
  let g:neomake_javascript_enabled_makers = ['eslint']
  " when switching/opening a JS buffer, set neomake's eslint path, and enable it as a maker
  autocmd BufEnter *.js let b:neomake_javascript_eslint_exe = nrun#Which('eslint')

  autocmd! BufWritePost * Neomake
"}}}

" Typescript & Javscript omni complete --------------------------------------{{{

  let g:tsuquyomi_disable_quickfix = 1
  let g:vim_json_syntax_conceal = 0
  set completeopt+=noselect
  autocmd FileType typescript setlocal completeopt+=menu,preview
  function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete=1
  endfunction
  function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete=0
  endfunction
  call deoplete#custom#set('buffer', 'mark', 'buffer')
  call deoplete#custom#set('ternjs', 'mark', '')
  call deoplete#custom#set('omni', 'mark', 'omni')
  call deoplete#custom#set('file', 'mark', 'file')
  let g:deoplete#omni_patterns = {}
  let g:deoplete#omni_patterns.html = ''

  let g:tern_request_timeout = 1
  let g:tern_show_signature_in_pum = 0
"}}}

" Python --------------------------------------{{{
  autocmd BufWritePost *.py call Flake8()
  let g:jedi#use_tabs_not_buffers = 1
  augroup python
    autocmd!
    autocmd FileType python setl sw=4 sts=4 et
    autocmd FileType python
                \   syn keyword pythonSelf self
                \ | highlight def link pythonSelf Special
    let g:SimpylFold_docstring_preview = 1
  augroup end
"}}}

" Tmux --------------------------------------{{{
if (!empty($TMUX))
  let g:slime_target = "tmux"
  let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
  let g:slime_python_ipython = 1
endif
"}}}
