if has('python3')
  silent! python3 1
endif
" vim: set foldmethod=marker foldlevel=0
" ============================================================================
" .vimrc of Xiuyu Li {{{
" ============================================================================

" ============================================================================
" Gotta be first {{{
" ============================================================================
set nocompatible

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
set encoding=utf-8
let mapleader=","
set number
set relativenumber
set ruler
set t_Co=256
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

" Do not create swap files, we're using git after all
set nobackup
set nowritebackup
set noswapfile

" Invisible characters
" autocmd BufEnter * set listchars=tab:▸\ ,eol:¬

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Use modeline overrides
set modeline
set modelines=10

" Status bar
set laststatus=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set term=screen-256color

" }}}
" ============================================================================
" NERDTree configuration {{{
" ============================================================================
let NERDTreeIgnore=['\.rbc$', '\~$']
" Nerd Tree (toggle)
map <Leader>n :NERDTreeToggle<CR>
" Nerd Tree (reveal current file)
map <Leader>nf :NERDTreeFind<CR>
" Close Nerdtree when selecting a file
let NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows=0

" }}}
" ============================================================================
" Some mapping with Leader key {{{
" ============================================================================
" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" Edit user .vimrc
map <Leader>rc :e ~/.vimrc<CR>

" split
nnoremap <leader>h :split<enter>
nnoremap <leader>v :vsplit<enter>

" Open/close tagbar with \b
nmap <silent> <leader>tb :TagbarToggle<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" }}}
" ============================================================================
" Remember last location in file {{{
" ============================================================================
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
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================
call plug#begin('~/.vim/plugged')

" ----- Making Vim look good ------------------------------------------
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
Plug 'vim-airline/vim-airline'

" ----- Vim as a programmer's text editor -----------------------------
Plug 'junegunn/fzf',        { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'terryma/vim-expand-region'
Plug 'justinmk/vim-sneak'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/ZoomWin'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'mattn/emmet-vim'

" ----- Working with Git ----------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ----- Syntax Plugs ------------------------------------------------
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-markdown'
Plug 'moll/vim-node'
Plug 'mmalecki/vim-node.js'
Plug 'ap/vim-css-color'
Plug 'elzr/vim-json'
Plug 'vim-syntastic/syntastic'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'sheerun/vim-polyglot'

" ---- Extras/Advanced Plugs ----------------------------------------
Plug 'christoomey/vim-tmux-navigator'
Plug 'ekalinin/Dockerfile.vim'

" ---- code format
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'
call plug#end()

" }}}
" ============================================================================
" Include user's local vim config {{{
" ============================================================================
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
" }}}

" }}}
" ============================================================================
" the glaive#Install() should go after the "call plug()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
  autocmd FileType swift AutoFormatBuffer swift-format
augroup END
" }}}

" ============================================================================
" snipmate {{{
" ============================================================================
" Configure snipmate dir
let g:snippets_dir="~/.vim/snippets"
" }}}

" ============================================================================
" File type specifics {{{
" ============================================================================
" Go
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <Leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>e <Plug>(go-rename)

" Go settings
map <C-n> :lne<CR>
map <C-m> :lp<CR>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let go_fmt_autosave = 1
let g:go_play_open_browser = 0
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" }}}

" ============================================================================
" make YCM compatible with UltiSnips (using supertab) {{{
" ============================================================================
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_global_ycm_extra_conf =
    \ '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>
" }}}

" ============================================================================
" better key bindings for UltiSnipsExpandTrigger {{{
" ============================================================================
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}

" ============================================================================
" autopair {{{
" ============================================================================
let g:AutoPairsMultilineClose=0
" }}}

" ============================================================================
" vim-sneak {{{
" ============================================================================
let g:sneak#streak = 1
nmap <bs> <Plug>SneakPrevious
xmap <bs> <Plug>SneakPrevious
" }}}

" ============================================================================
" vim-airline {{{
" ============================================================================
let g:airline#extensions#tabline#enabled = 1
" }}}

" ============================================================================
" syntastic {{{
" ============================================================================
let g:syntastic_javascript_checkers = ['standard']
autocmd bufwritepost *.js silent !standard --fix %
set autoread
" }}}

" ============================================================================
" FZF {{{
" ============================================================================
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
nnoremap <C-p> :FZF<Cr>
set rtp+=~/.fzf
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
" }}}

" ============================================================================
" Undotree toggle {{{
" ============================================================================
nnoremap U :UndotreeToggle<cr>
let g:jsx_ext_required = 0
" }}}

" ============================================================================
