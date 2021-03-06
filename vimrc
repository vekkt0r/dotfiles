syntax on
let mapleader = ','
set ts=2
set shiftwidth=2
set expandtab
set t_Co=256
set laststatus=2
set hlsearch
set ignorecase
set incsearch

" Kconfig macros
let @y = 'xx$3bd$i=ylx'
let @n = 'i# $hd$a is not set'

" Buffer navigation
set wildchar=<Tab> wildmenu wildmode=full
map <Leader>a :bprev<Return>
map <Leader>s :bnext<Return>
map <Leader>d :bprev<Return>:bd#<Return>
map <Leader>f :b#<Return>

" Leave insert mode with jk / kj
imap jk <Esc>
imap kj <Esc>

" Insert mode quick navigation
noremap! <Leader>h <left>
noremap! <Leader>j <down>
noremap! <Leader>k <up>
noremap! <Leader>l <right>
noremap! <Leader>w <esc>wi
noremap! <Leader>e <esc>ea
noremap! <Leader>b <esc>bi
noremap! <Leader>$ <esc>$a

" Git convenience
map <Leader>l :!tig %:p<Return>
map <Leader>B :!git blame %:p<Return>
map <Leader>D :!git diff %:p<Return>

" Trailing semicolon and exit insert mode
inoremap <Leader>; <C-o>$<C-o>A;<Esc>

" Open file in same directory convenience
map <Leader>o :e <C-r>%<C-w><C-w><C-w>
"map <Leader>h :e <C-r>%<C-h><C-h>hh<Return>
map <Leader>h :call CurtineIncSw()<Return>

" Add arguments for LOG_
inoremap <Leader>, <C-o>h<C-o>h,

" Trailing whitespace cleanup
map <Leader>w :%s/\s\+$//e<Return>

" Ack configuration
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
map <Leader>A :Ack! <C-r><C-w><Return>

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
set runtimepath+=~/src/dotfiles/snippets
let g:UltiSnipsSnippetDirectories=["~/.vim/UltiSnips", "UltiSnips"]

" Stuffs
set wildignore+=build,*.o,*.k,*.a,*.la,*.d,*.svg,*.png
set shell=/usr/bin/zsh

" Jump to last known position when opening file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" But not for gitcommit
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" Add format option 'w' to add trailing white space, indicating that paragraph
" " continues on next line. This is to be used with mutt's 'text_flowed'
" option.
augroup mail_trailing_whitespace " {
  autocmd!
  autocmd FileType mail setlocal formatoptions+=w
augroup END " }

" Avoid confusing MatchParen hilight
hi MatchParen cterm=bold ctermbg=none ctermfg=red

" Should be enabled for nerdcommenter
filetype plugin on

" ClangFormat setup
let g:clang_format#command = "clang-format-5.0"
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Plugin configuration
let g:airline_powerline_fonts = 1
execute pathogen#infect()
set runtimepath^=~/.vim/bundle/ag
