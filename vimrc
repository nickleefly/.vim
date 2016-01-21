" Gotta be first
set nocompatible
set encoding=utf-8
let mapleader=","

" Enable pathogen bundle loader
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

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
map <Leader>nf :NERDTreeFind<CR>
" Close Nerdtree when selecting a file
let NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows=0


" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" Edit user .vimrc
map <Leader>rc :e ~/.vimrc<CR>

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

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif


" ------------------------------------------------------------------------------
" snipmate
" ------------------------------------------------------------------------------
" Configure snipmate dir
let g:snippets_dir="~/.vim/snippets"

" ------------------------------------------------------------------------------
" File type specifics *
" ------------------------------------------------------------------------------
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

"-------------------------------------------------------------------------------
" Go settings
"-------------------------------------------------------------------------------
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


" Do not create swap files, we're using git after all
set nobackup
set nowritebackup
set noswapfile

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" CtrlP
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --hidden

  let g:ctrlp_match_window = 'bottom,order:ttb'
  let g:ctrlp_switch_buffer = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = ['ag %s --files-with-matches -g ""']
  let g:ctrlp_user_command +=
      \ ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command =
      \ ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif
nmap <Leader>p :CtrlPMRU<CR>

" make YCM compatible with UltiSnips (using supertab)
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

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" split
nnoremap <leader>h :split<enter>
nnoremap <leader>v :vsplit<enter>

" Open/close tagbar with \b
nmap <silent> <leader>tb :TagbarToggle<CR>

" autopair
let g:AutoPairsMultilineClose=0

" vim-sneak
let g:sneak#streak = 1
nmap <bs> <Plug>SneakPrevious
xmap <bs> <Plug>SneakPrevious

" vim-airline
let g:airline#extensions#tabline#enabled = 1

set rtp+=~/.fzf
set term=screen-256color
