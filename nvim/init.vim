call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug '~/src/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'rhysd/vim-clang-format'
Plug 'iCyMind/NeoSolarized'

" https://github.com/nickdiego/compiledb

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang'

call plug#end()

let mapleader = ','
set ts=2
set shiftwidth=2
set expandtab
set t_Co=256
set laststatus=2
" Deoplete keep preview window closed
set completeopt-=preview

" Kconfig macros
let @y = 'xx$3bd$i=yx'
let @n = 'i# ^[$hd$a is not set^['

" Trailing whitespace cleanup
map <Leader>w :%s/\s\+$//e<Return>

" Buffer navigation
map <Leader>a :bprev<Return>
map <Leader>s :bnext<Return>
map <Leader>d :bd<Return>
map <Leader>f :b#<Return>

" fzf
map <Leader>t :GFiles<Return>
map <Leader>T :Files<Return>
map <Leader>b :Buffers<Return>
map <Leader>A :Ag 

" GIT
map <Leader>l :te tig %<Return>i
map <Leader>B :te tig blame +<C-r>=line('.')<Return> %<Return>i
map <Leader>D :te git diff %<Return>i
map <Leader>z :!zcompiz %<Return>

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir = "~/.config/nvim/mySnippets"
let g:UltiSnipsSnippetDirectories = ['mySnippets', 'UltiSnips']

" ClangFormat setup
let g:clang_format#command = 'clang-format-5.0'
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Solarized theme
set termguicolors
set background=dark
colorscheme NeoSolarized
