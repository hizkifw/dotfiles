" ===========================================================================
" Display
" ===========================================================================

colorscheme afterglow
if $COLORTERM == 'gnome-terminal' || $VIM_COLORFUL == 1
    set t_Co=256
    " Fix weird colors on scroll
    set t_ut=
endif

" Show line numbers
set number
" Vertical cursor margin
set so=5
" Show vim commands
set showcmd
" Ruler at 80 chars and 120+
let &colorcolumn="80,".join(range(120,999),",")

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Search highlight
set is

" Override italics escape sequences for tmux
set t_ZH=[3m
set t_ZR=[23m

" Set a custom tabline to remove the 'x' button
" based off :h setting-tabline

:set tabline=%!MyTabLine()

function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let name = bufname(buflist[winnr - 1])
  if len(name) == 0
    return "[*]"
  endif
  return name
endfunction

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  return s
endfunction

" Powerline status
" if has("python3")
"     python3 from powerline.vim import setup as powerline_setup
"     python3 powerline_setup()
"     python3 del powerline_setup
"     set laststatus=2
"     set showtabline=2
"     set noshowmode
"     set noshowcmd
"     set shortmess+=F
" endif

