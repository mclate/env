set bg=dark
"set t_Co=256
set laststatus=2
syntax on
set autoindent
set nu
set modeline

au InsertEnter * hi StatusLine ctermfg=red ctermbg=white 
au InsertLeave * hi StatusLine ctermfg=black ctermbg=white

hi statusline ctermbg=white ctermfg=black

nmap <Tab> :tabnext<CR>
nmap <S-Tab> :tabprevious<CR>


:map <UP> <NOP>
:map <DOWN> <NOP>
:map <LEFT> <NOP>
:map <RIGHT> <NOP>
:map <HOME> <NOP>
:map <END> <NOP>
:map <PageUp> <NOP>
:map <PageDown> <NOP>
:map <Del> <NOP>


set tabstop=4
set shiftwidth=4
set expandtab 

set scrolloff=8 "Start scrolling when we're 8 lines away from margins

" F5 to remove all trailing spaces
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
:nnoremap <silent> <S-F5> :let _s=@/<Bar>:%s/\t/    /ge<Bar>:let @/=_s<Bar>:nohl<CR>
