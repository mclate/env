set nu
set bg=dark
set modeline
set expandtab 
set tabstop=4
set autoindent
set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set laststatus=2
set shiftwidth=4
"set t_Co=256

au InsertEnter * hi StatusLine ctermfg=red ctermbg=white 
au InsertLeave * hi StatusLine ctermfg=black ctermbg=white

hi statusline ctermbg=white ctermfg=black

syntax on

nmap <Tab> :tabnext<CR>
nmap <S-Tab> :tabprevious<CR>

:map <UP> <NOP>
:map <Del> <NOP>
:map <END> <NOP>
:map <DOWN> <NOP>
:map <LEFT> <NOP>
:map <HOME> <NOP>
:map <RIGHT> <NOP>
:map <PageUp> <NOP>
:map <PageDown> <NOP>

" F5 to remove all trailing spaces
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
:nnoremap <silent> <S-F5> :let _s=@/<Bar>:%s/\t/    /ge<Bar>:let @/=_s<Bar>:nohl<CR>
