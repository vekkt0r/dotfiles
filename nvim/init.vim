call plug#begin('~/.local/share/nvim/plugged')

Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/nvim-yarp'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'rhysd/vim-clang-format'
Plug 'ishan9299/nvim-solarized-lua'
Plug 'scrooloose/nerdcommenter'
Plug 'vekkt0r/toggle-bool'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-surround'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'vekkt0r/vim-monkey-c'
Plug 'axvr/org.vim'
Plug 'krzbe/fzf-git-submodules'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'voldikss/vim-floaterm'

let g:LanguageClient_serverCommands = {
  \ 'c': ['/usr/bin/clangd'],
  \ 'cpp': ['/usr/bin/clangd'],
  \ 'python': ['/usr/local/bin/pyls'],
  \ }

let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

call plug#end()

lua <<EOF
local npairs = require('nvim-autopairs')

npairs.setup({
    check_ts = true,
    })

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
        ["punctuation.bracket"] = "Variable",
        ["punctuation.delimiter"] = "Variable",
        ["keyword.function"] = "Keyword",
        ["include"] = "Keyword",
    }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}
EOF

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
"set completeopt=menuone,noinsert,noselect,preview
set completeopt=menuone,noinsert,noselect
"inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

"let g:LanguageClient_userVirtualText = 0
let g:LanguageClient_hasSnippetSupport = 1
let g:LanguageClient_selectionUI = 'FZF'

let mapleader = ','
set ts=2
set shiftwidth=2
set expandtab
set t_Co=256
set laststatus=2
set hlsearch
set ignorecase
set incsearch
set undofile
" always center scroll, better buffer switching
set scrolloff=999
" Deoplete keep preview window closed
"set completeopt-=preview

" Kconfig macros
let @y = 'xx$3bd$i=yx'
let @n = 'i# ^[$hd$a is not set^['

" Leave insert mode with jk / kj
imap jk <Esc>
imap kj <Esc>

" Build current file with F10
map <F10> :!build.sh %:p:h<Return><Return>
map <C-b> :!build.sh %:p:h<Return><Return>

" Convenience macro for w3m
map <Leader>W :te w3m %<Return>i

" Trailing semicolon and exit insert mode
inoremap <Leader>; <C-o>$<C-o>A;<Esc>

" Open file in same directory convenience
map <Leader>o :e <C-r>%<C-w><C-w><C-w>

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
map <Leader>H :e %:p:s,.hh$,.X123X,:s,.cc$,.hh,:s,.X123X$,.cc,<Return>
"map <Leader>H :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<Return>

" fzf
let g:fzf_preview_window = ''
map <Leader>t :GFiles<Return>
map <Leader>F :Files<Return>
map <Leader>b :Buffers<Return>
map <Leader>A :Ag <C-r><C-w>
map <Leader>L :BLines 
map <Leader>g :BTags<Return>
map <Leader>C :Components<Return>

" GIT
map <Leader>l :FloatermNew tig %<Return>i
map <Leader>L :FloatermNew tig --follow %<Return>i
map <Leader>B :FloatermNew tig blame +<C-r>=line('.')<Return> %<Return>i
map <Leader>D :FloatermNew git diff %<Return>i
map <Leader>S :FloatermNew tig status<Return>i
map <Leader>V :FloatermNew git checkout -p %<Return>i

" Smart semicolon
inoremap <Leader>; <C-o>A;<Esc>

" Insert mode quick navigation
noremap! <Leader>h <left>
noremap! <Leader>j <down>
noremap! <Leader>k <up>
noremap! <Leader>l <right>
noremap! <Leader>w <esc>wi
noremap! <Leader>e <esc>ea
noremap! <Leader>b <esc>bi
noremap! <Leader>$ <esc>$a

" Toggle word
map <Leader>T :ToggleBool<Return>

" NNN launch in current dir
map <Leader>n :te nnn %:p:h<Return>i

" Fix comments for MonkeyC
augroup SetCMD
  autocmd FileType monkeyc let &l:commentstring='// %s'
augroup END

" Floaterm
let g:floaterm_height=1.0
let g:floaterm_width=0.8

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir = "~/.config/nvim/mySnippets"
let g:UltiSnipsSnippetDirectories = ['mySnippets', 'UltiSnips']

" Git mergetool shortcuts
if &diff
  map <Leader>1 :diffget LOCAL<CR>
  map <Leader>2 :diffget BASE<CR>
  map <Leader>3 :diffget REMOTE<CR>
endif

" ClangFormat setup
let g:clang_format#command = 'clang-format'
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
autocmd FileType python nnoremap <buffer><Leader>cf :silent !black -S %<CR><CR>

" LanguageClient
nnoremap <Leader>m :call LanguageClient_contextMenu()<CR>
nnoremap <Leader>c :call LanguageClient_textDocument_codeAction()<CR>

" Org mode customization
let g:org_clean_folds = 1

" MultiMarkdown -> Markdown mode
autocmd BufNewFile,BufRead *.mmd set filetype=markdown

" Jump to last known position when opening file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Solarized theme
set termguicolors
colorscheme solarized-flat
