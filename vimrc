syntax on
let mapleader = ','
set ts=4
set shiftwidth=4
set expandtab
set t_Co=256
set laststatus=2

" Kconfig macros
let @y = 'xx$3bd$i=ylx'
let @n = 'i# $hd$a is not set'

" Buffer navigation
set wildchar=<Tab> wildmenu wildmode=full
map <Leader>a :bprev<Return>
map <Leader>s :bnext<Return>
map <Leader>d :bprev<CR>bd #<Return>
map <Leader>f :b#<Return>

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

" Avoid confusing MatchParen hilight
hi MatchParen cterm=bold ctermbg=none ctermfg=red

" ConqueGdb setup
let g:ConqueGdb_GdbExe = "arm-linux-gnueabihf-gdb"
let g:ConqueGdb_Leader = '\'
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CloseOnEnd = 1

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
