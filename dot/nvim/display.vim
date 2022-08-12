" ===========================================================================
" Display
" ===========================================================================

if has('termguicolors')
    set termguicolors
endif

" Color scheme
set t_Co=256
set background=dark
colorscheme PaperColor

" Airline
let g:airline_theme='papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Show line numbers
set number
" Vertical cursor margin
set so=5
" Show vim commands
set showcmd
" Ruler at 80 chars and 120+
let &colorcolumn="80,".join(range(120,999),",")
" Goyo width
let g:goyo_width=82

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Search highlight
set is

" Override italics escape sequences for tmux
set t_ZH=[3m
set t_ZR=[23m

" Neovide settings
set guifont=FiraCode\ Nerd\ Font\ Mono:h11
if exists("g:neovide")
    let g:neovide_cursor_animation_length=0.05
endif
