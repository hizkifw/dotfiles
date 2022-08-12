" ===========================================================================
" Plugins
" ===========================================================================

" PlugVim
runtime! ftplugin/man.vim
set rtp+=$HOME/.local/lib/python3.5/site-packages/powerline/bindings/vim/
call plug#begin(vimhome . '/plugvim')

" Display
Plug 'NLKNguyen/papercolor-theme'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'psliwka/vim-smoothie'
Plug 'szw/vim-maximizer'

" Utilities
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'alvan/vim-closetag'
Plug 'junegunn/goyo.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tcbbd/detectindent'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'psf/black', { 'branch': 'stable' }
Plug 'airblade/vim-gitgutter'
Plug 'diepm/vim-rest-console'
Plug 'skywind3000/asyncrun.vim'

" Code completion
Plug 'neoclide/coc.nvim', { 'do': 'yarn install' }
Plug 'github/copilot.vim'

" Typescript support
Plug 'leafgarland/typescript-vim'

" Other languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'TovarishFin/vim-solidity'
Plug 'rust-lang/rust.vim'
call plug#end()

" NERDTree
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeNaturalSort = 1
let g:NERDTreeIgnore = ['^node_modules$']

" NERDCommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" EasyMotion
nmap ; <Plug>(easymotion-s)

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
  \ 'typescript.tsx': 'jsxRegion,tsxRegion',
  \ 'javascript.jsx': 'jsxRegion',
  \ 'typescriptreact': 'jsxRegion,tsxRegion',
  \ 'javascriptreact': 'jsxRegion',
  \ }
let g:closetag_shortcut = '>'

" DetectIndent
augroup DetectIndent
  autocmd!
  autocmd BufReadPost * DetectIndent
augroup END

" Prettier every file save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.json,*.css,*.scss,*.less,*.graphql,*.html,*.md,*.mdx PrettierAsync
autocmd BufWritePre *.rs RustFmt
autocmd BufWritePre *.py Black
autocmd BufWritePre *.go GoFmt
autocmd BufWritePost *.gd AsyncRun -post=e! gdformat %

" ctrlpvim/ctrlp.vim
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" ===========================================================================
" Conquer of Completion
" ===========================================================================
set updatetime=300
set hidden
let g:coc_global_extensions = [
    \   'coc-tsserver',
    \   'coc-snippets',
    \   'coc-python',
    \   'coc-json',
    \   'coc-rust-analyzer',
    \   'coc-deno',
    \ ]

" close all popups on esc
nnoremap <silent> <esc> :call coc#float#close_all()<cr><esc>

" Always show the line number gutter
set signcolumn=yes

" Map tab to autocomplete
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ copilot#Accept("\<Tab>")
let g:copilot_no_tab_map = v:true
let g:coc_snippet_next = '<tab>'

" popup scrolling
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" manually trigger completion
inoremap <silent><expr> <C-m> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Rename
nmap <F2> <Plug>(coc-rename)

" Code action
nmap <leader>do <Plug>(coc-codeaction)
