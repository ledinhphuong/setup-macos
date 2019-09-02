"
" Copyright (c) 2017 Le Dinh Phuong

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set history=10000
set autoread " reloads changes outside vim
set backspace=indent,eol,start
set ruler
set number " shows line number
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


" Enable filetype plugins
filetype plugin on
filetype indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color and font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
"let g:onedark_termcolors=256
"colorscheme onedark
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
call togglebg#map("<F5>")

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

" Install fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Install nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Install YouCompleteMe
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

" Install vim-gitgutter - Show diff markers
Plug 'airblade/vim-gitgutter'

" Install linter
Plug 'w0rp/ale'

" Install vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline configuration. Require to install Powerline's fonts
" https://github.com/powerline/fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
let g:airline_theme="solarized"
let g:airline_powerline_fonts = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" eslint configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.js
  \ let g:ale_lint_on_save = 1

"au BufNewFile,BufRead *.py
"  \ set tabstop = 4
"  \ set softtabstop = 4
"  \ set shiftwidth = 4
"  \ set textwidth = 80
"  \ set fileformat = unix
"  \ let python_highlight_all = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=250 " needs for gitgutter detect and show diff markers faster
let g:gitgutter_async=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bind \ (backward slash) to grep shortcut
" Needs to install the_silver_searcher first
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap \ :Ag<SPACE>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap ` :Files<CR>
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap ~ :NERDTreeToggle<CR>
execute pathogen#infect()
call pathogen#helptags()
let NERDTreeShowHidden=1

" Open nerdtree by default
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
