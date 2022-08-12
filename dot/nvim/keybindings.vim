" ===========================================================================
" Keybindings
" ===========================================================================

" Set leader to spacebar
let mapleader = " "
let g:mapleader = " "

" Add lines surrounding
nmap <leader>o O<esc>jo<esc>ki
" Quicksave
nmap              <leader>w   :w<cr>
nmap              <leader>W   :w!<cr>
noremap  <silent> <C-S>       :update<CR>
vnoremap <silent> <C-S>  <C-C>:update<CR>
inoremap <silent> <C-S>  <C-O>:update<CR>

" Quickclose
nmap <leader>cl :clo<cr>

" Toggle NerdTree
function! ToggleNERDTree()
  if exists("b:NERDTree") || len(expand('%:p')) == 0
    NERDTreeToggle
  else
    NERDTreeFind
  endif
endfunction
nmap <silent> <leader>n :call ToggleNERDTree()<cr>

command! ReloadBuffers :bufdo e

" Toggle Goyo
nmap <silent> <leader>go :Goyo<cr>
" Creating tabs and windows
nmap <silent> <leader>t :tab split<cr>
nmap <silent> <leader>v :vsplit<cr>
nmap <silent> <leader>e :split<cr>
nmap          <leader><cr> <C-w>w
" Moving around tabs and windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nmap <leader>gj <C-W>j
nmap <leader>gk <C-W>k
nmap <leader>gh <C-W>h
nmap <leader>gl <C-W>l
nmap <leader>j gt
nmap <leader>k gT
nmap <leader>h :tabm -1<cr>
nmap <leader>l :tabm +1<cr>
" Basic window layout manipulation
nmap <leader>sl <C-w>L
nmap <leader>sk <C-w>K
nmap <leader>sj <C-w>J
nmap <leader>sh <C-w>H
nmap <up> :resize +2<cr>
nmap <down> :resize -2<cr>
nmap <right> :vertical resize +2<cr>
nmap <left> :vertical resize -2<cr>
" Maximizer
nmap <leader>z :MaximizerToggle<cr>
" Spellcheck
map <leader>sc :setlocal spell!<cr>
" Yank to end of line
map Y y$
" Remap F1 key to Escape
map <F1> <Esc>
imap <F1> <Esc>
" Put current buffer to clipboard
nmap <leader>y :w !xclip -selection clipboard<cr><cr>
vmap <leader>y :'<,'>w !xclip -selection clipboard<cr><cr>
" Git
nmap <silent> <leader>gip :GitGutterPreviewHunk<cr>
" Terminal
nmap <silent> <leader>mt :tabnew +terminal<cr>i
nmap <silent> <leader>me :new    +terminal<cr>i
nmap <silent> <leader>mv :vnew   +terminal<cr>i

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Fix Python indents
inoremap # X<bs>#

