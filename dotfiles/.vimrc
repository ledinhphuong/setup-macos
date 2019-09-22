"
" Copyright (c) 2017 Le Dinh Phuong

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set history=10000
set autoread " reloads changes outside vim
set backspace=indent,eol,start
set ruler
set relativenumber " shows line number
set cursorline " highlight current line
set showmode
set showcmd
set wildmenu " visual autocomplete for command menu
set hlsearch " highlight search matches
set visualbell " no sounds
set scrolloff=4 " lines margin when scrolling
set foldmethod=indent " enable folding - za
set foldlevel=99
autocmd BufWritePre * :%s/\s+$//e
set completeopt-=preview


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab and indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent
set smarttab

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set nowrap
set linebreak

set mouse=a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Manage plugins
" - :PlugInstall <enter>
" - :PlugClean <enter>
" - :PlugStatus <enter>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
  " Outline
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } 
  Plug 'Xuyuanp/nerdtree-git-plugin' 
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  " Colorthemes
  Plug 'dracula/vim', { 'as': 'dracula' }

  " Fuzzy finder, auto complete, lint...
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim' 
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
  Plug 'dense-analysis/ale'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'
  Plug 'sheerun/vim-polyglot'
  
  " Javascript development
  Plug 'pangloss/vim-javascript'
call plug#end()


" Enable filetype plugins
filetype plugin on
filetype indent on

if exists('g:plugs["vim-javascript"]')
  let g:javascript_plugin_jsdoc = 1
endif

if exists('g:plugs["tern_for_vim"]')
  let g:tern_map_keys=1
  let g:tern_show_argument_hints='on_hold'
endif

if exists('g:plugs["vim-gitgutter"]')
  set updatetime=250 " needs for gitgutter detect and show diff markers faster
  let g:gitgutter_async=0
endif

if exists('g:plugs["vim-airline"]')
  set t_Co=256
  let g:airline_theme="solarized"
  let g:airline_powerline_fonts = 1
endif

if exists('g:plugs["fzf"]')
  noremap ` :Files<CR>
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
endif

if exists('g:plugs["nerdtree"]')
  noremap ~ :NERDTreeToggle<CR>
  let NERDTreeShowHidden=1

  " Open nerdtree by default
  "autocmd StdinReadPre * let s:std_in=1
  "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
endif

if exists('g:plugs["ale"]')
  let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'python': ['pylint', 'flake8'],
  \}

  au BufNewFile,BufRead *.js,*.py
    \ let g:ale_lint_on_save = 1

  "au BufNewFile,BufRead *.py
  "  \ set tabstop = 4
  "  \ set softtabstop = 4
  "  \ set shiftwidth = 4
  "  \ set textwidth = 80
  "  \ set fileformat = unix
  "  \ let python_highlight_all = 1
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bind \ (backward slash) to grep shortcut
" Needs to install the_silver_searcher first
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap \ :Ag<SPACE>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorthemes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set termguicolors " turn on true colors
set background=dark

" ondark theme
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
colorscheme onedark

" solarized theme
"let g:solarized_termcolors=256
"let g:solarized_termtrans=0
"colorscheme solarized
"colorscheme solarized8
"call togglebg#map("<F5>")

" dracula
"colorscheme dracula
