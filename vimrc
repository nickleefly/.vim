" Gotta be first
set nocompatible
filetype off

set encoding=utf-8
let mapleader=","

set number
set relativenumber
set ruler
syntax on

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Invisible characters
" autocmd BufEnter * set listchars=tab:▸\ ,eol:¬

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
" Nerd Tree (toggle)
map <Leader>n :NERDTreeToggle<CR>
" Nerd Tree (reveal current file)
map <Leader>f :NERDTreeFind<CR>
" Close Nerdtree when selecting a file
let NERDTreeQuitOnOpen=1


" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" Edit user .vimrc
map <Leader>r :e ~/.vimrc<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ----- Making Vim look good ------------------------------------------
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'bling/vim-airline'

" ----- Vim as a programmer's text editor -----------------------------
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab.git'
Plugin 'honza/vim-snippets.git'
Plugin 'SirVer/ultisnips.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'justinmk/vim-sneak.git'
Plugin 'Raimondi/delimitMate'
Plugin 'mbbill/undotree'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/ZoomWin.git'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'mattn/emmet-vim'

" ----- Working with Git ----------------------------------------------
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter.git'

" ----- Syntax plugins ------------------------------------------------
Plugin 'briancollins/vim-jst.git'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-haml'
Plugin 'fatih/vim-go'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-markdown'
Plugin 'moll/vim-node'
Plugin 'mmalecki/vim-node.js'
Plugin 'wavded/vim-stylus'
Plugin 'ap/vim-css-color'
Plugin 'elzr/vim-json'
Plugin 'Blackrush/vim-gocode.git'

" ---- Extras/Advanced plugins ----------------------------------------
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mattn/gist-vim.git'
Plugin 'ekalinin/Dockerfile.vim'

" load the plugin and indent settings for the detected filetype
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color default

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif