set nocompatible              " be iMproved, required
filetype off                  " required

" Install Plugins

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Default Plugins
Plugin 'tpope/vim-fugitive'
" Plugin 'git://git.wincent.com/command-t.git'
Plugin 'wincent/command-t'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Custom Plugins
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'Valloric/YouCompleteMe'
Plugin 'joukevandermaas/vim-ember-hbs'

call vundle#end()            " required
filetype plugin indent on    " required

" Color Configuration
set t_Co=256 " 256 colors
set guifont=Menlo:h14
highlight Comment ctermfg=lightblue

" General Configuration
syntax enable
set number
set shiftwidth=2

set tabstop=2
set expandtab
let g:vim_json_syntax_conceal = 0
set cursorline

" Remap Window Movement 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set more natural split behavior
set splitbelow
set splitright
