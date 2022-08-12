"
" HizkiFW's .vimrc
"

" ===========================================================================
" General
" ===========================================================================

" Set .vim directory
let vimhome = $HOME . '/.config/nvim'
if !isdirectory(vimhome . '/temp')
    call mkdir(vimhome . '/temp', "", 0700)
endif

filetype plugin on
filetype indent on

" Enable mouse support
set mouse=a

" Auto read file when changed
set autoread

" Indentation stuff
set tabstop=2
set shiftwidth=2
set smarttab
set smartindent
set autoindent
set expandtab

" Code folding
set foldmethod=indent
set nofoldenable

" Disable vim swap files
set noswapfile

" No line wrapping
set nowrap
" Except for certain files
autocmd BufNewFile,BufReadPost *.md,*.mdx set filetype=markdown
autocmd BufNewFile,BufReadPost *.txt set filetype=plaintext
augroup WrapLine
    autocmd!
    autocmd FileType markdown,plaintext,tex setlocal linebreak
    autocmd FileType markdown,plaintext,tex setlocal wrap
augroup END

" Disable sounds
set noeb vb t_vb=
au GUIEnter * set vb t_vb=

" Persistent undo
try
    let undodir = vimhome . '/temp/undodir'
    if !isdirectory(undodir)
        call mkdir(undodir, "", 0700)
    endif
    let &undodir = undodir
    set undofile
catch
endtry

" Use system clipboard
if has('clipboard')
    set clipboard=unnamedplus
endif

" Session options
set sessionoptions=blank,winsize,tabpages,resize,buffers,help

" Encoding stuff
set encoding=utf8
set ffs=unix,dos,mac

" sudo save
command! W exec 'w !sudo dd of=' . shellescape(expand('%'))

" Load other configs
source $HOME/.config/nvim/keybindings.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/display.vim
