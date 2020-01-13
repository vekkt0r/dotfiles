call plug#begin('~/.local/share/nvim/plugged')

Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/nvim-yarp'
Plug '~/src/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'rhysd/vim-clang-format'
Plug 'iCyMind/NeoSolarized'
Plug 'scrooloose/nerdcommenter'
Plug 'sagarrakshe/toggle-bool'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-surround'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

let g:LanguageClient_serverStderr = '/tmp/clangd.stderr'
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd-6.0', '-enable-snippets'],
  \ }

call plug#end()

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

let g:LanguageClient_hasSnippetSupport = 1

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

" Build current file with F10
map <F10> :!build.sh %:p:h<Return><Return>

" Convenience macro for w3m
map <Leader>W :te w3m %<Return>i

" Trailing whitespace cleanup and hilight
map <Leader>w :%s/\s\+$//e<Return>
set list

" Relative numbering, not for Term
set number relativenumber
au TermOpen * setlocal nonumber norelativenumber

" Buffer navigation
map <Leader>a :bprev<Return>
map <Leader>s :bnext<Return>
map <Leader>d :bd<Return>
map <Leader>f :b#<Return>
map <Leader>H :e %:r.h<Return>

" fzf
map <Leader>t :GFiles<Return>
map <Leader>F :Files<Return>
map <Leader>b :Buffers<Return>
map <Leader>A :Ag <C-r><C-w>
map <Leader>L :BLines 

" GIT
map <Leader>l :te tig %<Return>i
map <Leader>B :te tig blame +<C-r>=line('.')<Return> %<Return>i
map <Leader>D :te git diff %<Return>i
map <Leader>z :!codemapper map %<Return>
map <Leader>S :te tig status<Return>i
map <Leader>V :te git checkout -p %<Return>i

" Toggle word
map <Leader>T :ToggleBool<Return>

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

" LanguageClient
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" MultiMarkdown -> Markdown mode
autocmd BufNewFile,BufRead *.mmd set filetype=markdown

" Jump to last known position when opening file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Solarized theme
set termguicolors
set background=dark
colorscheme NeoSolarized
