set nocompatible


"APPEARANCE
"----------

"Terminal specific options
"set t_Co=256  Should not be necessary if XTERM is set correctly

colorscheme molokai

"Custom status line contents, and always display the status line
set statusline=%t%m%r%w\ [Type:%Y]\ %=[Chr:\%03.3b/0x\%02.2B]\ [Pos:%3l/%-3L,%3v]\ [%p%%]
set laststatus=2

"Color the status line in insert mode since terminals don't change cursor shape
hi StatusLine term=reverse ctermbg=17 ctermfg=White 
au InsertEnter * hi StatusLine term=reverse ctermbg=DarkRed ctermfg=Yellow 
au InsertLeave * hi StatusLine term=reverse ctermbg=17 ctermfg=White 

"Uncomment these to highline cursor line
"set cursorline
"autocmd InsertEnter * highlight  CursorLine ctermbg=DarkGrey ctermfg=Red
"autocmd InsertLeave * highlight  CursorLine ctermbg=Black ctermfg=None

"Set GUI specific options
"set guifont=Courier\ New:h11
set guioptions=egmrL


"BEHAVIOR
"--------

set hlsearch
set linebreak
set scrolloff=2
set shiftwidth=5
set tabstop=5
set dictionary+=~/.vimdictionary
set clipboard=unnamed
set nobackup
set ruler
set number

"Plugin options
let MRU_Use_Current_Window = 1



"KEYBOARD MAPPING
"----------------

"Space disables the current search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

"Keypad operators control size of current window
map <kPlus> <C-W>+
map <kMinus> <C-W>-
map <kDivide> <C-W><
map <kMultiply> <C-W>>

"Keypad period goes to BOF / typed line number
map <kPoint> G

"F1 = Yank whole document
map <F1> :%y+

"F3 = Autocomplete from existing text
inoremap <F3> <C-X><C-P>

"F4 = Correct next spelling
map <F4> ]sz=

"F5 = Next ========= separated section
map <silent> <F5> :set nowrapscan/=\+\n:noh:set wrapscanzt

"F6 = Previous ========= separated section
map <silent> <F6> :set nowrapscan?=\+\n:noh:set wrapscanzt

"F7 = Save and Make
map <F7> :w:make

"F9 = Fold/unfold/make visual fold
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

"Control A to increment numbers in text is dangerous now I've learnt tmux
"Instead, use it to simulate a double Ctrl+W cycling current pane
nnoremap <C-a> <C-w><C-w>


"FUNCTIONS
"---------

function! ToggleSpell()
  if !exists("g:spell_on")
    let g:spell_on = 1
  endif
  let g:spell_on = 1 - g:spell_on
  execute "set " . (g:spell_on ? "spell" : "nospell" )
  echo "Spelling currently " . g:spell_on
endfunction


set diffexpr=MyDiff()

function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  ; else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

 

"Automatically reread (source) vimrc when we save it inside vim
au! BufWritePost $MYVIMRC source %

