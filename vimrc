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
map <Leader>d :bd<Return>
map <Leader>f :b#<Return>
inoremap <Leader>; <C-o>$<C-o>A;<Esc>
inoremap <Leader>, <C-o>h<C-o>h,

" Stuffs
set wildignore+=build,*.o,*.k,*.a,*.la,*.d,*.svg,*.png

" Jump to last known position when opening file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" But not for gitcommit
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" Plugin configuration
let g:airline_powerline_fonts = 1
execute pathogen#infect()
set runtimepath^=~/.vim/bundle/ag
