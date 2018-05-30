"
" Copyright (c) 2017 Le Dinh Phuong

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set history=1000
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

" Enable filetype plugins
filetype plugin on
filetype indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color and font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
colorscheme onedark


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab and indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent
set smarttab

set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set nowrap
set linebreak

set mouse=a
