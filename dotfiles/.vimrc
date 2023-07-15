"
" Copyright (c) 2017 Le Dinh Phuong

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set history=10000
set autoread " reloads changes outside vim
au CursorHold * checktime
set backspace=indent,eol,start
set ruler
set number
set relativenumber " shows line number
set cursorline " highlight current line
set showmode
set showcmd
set wildmenu " visual autocomplete for command menu
set hlsearch " highlight search matches
set visualbell " no sounds
set scrolloff=3 " lines margin when scrolling
set foldmethod=indent " enable folding - za
set foldlevel=99
set completeopt-=preview
set clipboard=unnamed

" Press f to search the word under the cursor in file
nnoremap f /<C-r><C-w><ENTER>
" Press F to search the word under the cursor in files
nnoremap F :Ag<SPACE><C-r><C-w><ENTER>
" Press Command+f to replace selected text in file
nnoremap <C-f> :%s/<C-r><C-w>//gc<left><left><left>
nnoremap <C-F> :bufdo %s/<C-r><C-w>//gce<left><left><left><left>
" Press s to save this file
nnoremap s :w<ENTER>
" Press x to clear selected texts
nnoremap x :noh<ENTER>
" Press r to reload .vimrc file
nnoremap r :source<SPACE>~/.vimrc<ENTER>
" Map <Leader> key, comment code: ,cc; uncomment code: ,cu
let mapleader=","
set timeout timeoutlen=1500


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

" Wrapping text
set wrap
set linebreak

set mouse=a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Manage plugins
" - :PlugInstall <enter>
" - :PlugClean <enter>
" - :PlugStatus <enter>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! BuildMarkdownComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction

call plug#begin('~/.vim/plugged')
  " Outline
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'APZelos/blamer.nvim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'Yggdroot/indentLine'
  " Plug 'pseewald/vim-anyfold'

  " Colorthemes
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'joshdick/onedark.vim', {'as': 'onedark'}
  Plug 'tomasr/molokai', {'as': 'molokai'}
  Plug 'morhetz/gruvbox', {'as': 'gruvbox'}
  Plug 'altercation/vim-colors-solarized', {'as': 'solarized'}
  Plug 'lifepillar/vim-solarized8', { 'dir': '~/.config/nvim/colors/solarized8' }

  " Fuzzy finder, auto complete, lint...
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'ycm-core/YouCompleteMe', { 'branch': 'master', 'do': './install.py --tern-completer' }
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
  Plug 'dense-analysis/ale'
  "Plug 'jiangmiao/auto-pairs'
  "Plug 'tpope/vim-surround'
  Plug 'sheerun/vim-polyglot'
  " Plug 'terryma/vim-multiple-cursors'

  " Javascript language
  Plug 'pangloss/vim-javascript'

  " Python language
  Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

  Plug 'wfxr/protobuf.vim'

  Plug 'scrooloose/nerdcommenter'

  "Plug 'euclio/vim-markdown-composer', {'do': function('BuildMarkdownComposer')}

  " Generative AI
  Plug 'github/copilot.vim'
call plug#end()

" Enable filetype plugins
filetype plugin on
filetype indent on

if exists('g:plugs["blamer.nvim"]')
  let g:blamer_enabled = 1
  let g:blamer_delay = 300
endif

if exists('g:plugs["indentLine"]')
  let g:indentLine_enabled = 1
  let g:indentLine_setConceal = 0
endif

if exists('g:plugs["nerdcommenter"]')
  " Add spaces after comment delimiters by default
  let g:NERDSpaceDelims = 1

  " Use compact syntax for prettified multi-line comments
  let g:NERDCompactSexyComs = 1

  " Align line-wise comment delimiters flush left instead of following code indentation
  let g:NERDDefaultAlign = 'left'

  " Set a language to use its alternate delimiters by default
  let g:NERDAltDelims_java = 1

  " Add your own custom formats or override the defaults
  let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

  " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDCommentEmptyLines = 1

  " Enable trimming of trailing whitespace when uncommenting
  let g:NERDTrimTrailingWhitespace = 1

  " Enable NERDCommenterToggle to check all selected lines is commented or not
  let g:NERDToggleCheckAllLines = 1
endif

if exists('g:plugs["python-mode"]')
  let g:pymode_python = 'python3'
  let g:pymode_options_max_line_length = 100
  let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
  "let g:pymode_lint_checkers = ['pylint', 'pep8']
endif

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
  let g:airline_theme="deus"
  let g:airline_powerline_fonts = 1
endif

if exists('g:plugs["fzf"]')
  noremap ` :Files<CR>
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
endif

if exists('g:plugs["nerdtree"]')
  noremap ~ :NERDTreeToggle<CR>
  let NERDTreeShowHidden = 1

  " Open nerdtree by default
  "au VimEnter *  NERDTree
endif

if exists('g:plugs["ale"]')
  let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'python': ['pylint', 'flake8'],
  \}

  au BufNewFile,BufRead *.js,*.py
    \ let g:ale_lint_on_save = 1

  let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \}

  let g:ale_fix_on_save = 1

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

""""""""" ondark theme """""""""
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
colorscheme onedark

""""""""" molokai theme """""""""
"let g:molokai_original = 1
"let g:rehash256 = 1
"colorscheme molokai " Normal text is light white. True tone

""""""""" gruvbox """""""""
" colorscheme gruvbox " True tone. Darker than molokai

""""""""" dracula theme """""""""
"colorscheme dracula " Normal text is light white. Green color is too much.

""""""""" solarized theme """""""""
"let g:solarized_termcolors=256
"let g:solarized_termtrans=0
"colorscheme solarized " number bar isn't eye-caught
"colorscheme solarized8 " background is too blur
"call togglebg#map("<F5>")
