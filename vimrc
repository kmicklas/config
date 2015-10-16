noremap ; :
noremap <Space> i
noremap <CR> i
noremap j h
noremap i k
noremap k j
noremap <c-p> "+p
vnoremap <c-p> "+p
noremap <c-c> "+y
vnoremap <c-c> "+y
noremap <c-x> "+d
vnoremap <c-x> "+d
noremap <c-d> d
vnoremap <c-d> d
imap <S-Space> <Esc>
imap <C-Space> <Esc>
imap jk <Esc>
noremap h "+

colorscheme evening
syntax on
set hlsearch
set mouse=a
set nobackup
set noswapfile
set number
set tabstop=4
set shiftwidth=4
set smartcase
set autoindent
set copyindent
set virtualedit=onemore
set gdefault

au BufEnter *.arr set syntax=pyret
au BufEnter *.arr set shiftwidth=2
au BufEnter *.arr set softtabstop=2
au BufEnter *.arr set expandtab

au BufEnter *.hs set shiftwidth=2
au BufEnter *.hs set softtabstop=2
au BufEnter *.hs set expandtab

au BufEnter *.idr set shiftwidth=2
au BufEnter *.idr set softtabstop=2
au BufEnter *.idr set expandtab

au BufEnter *.x set syntax=alex
au BufEnter *.x set shiftwidth=2
au BufEnter *.x set softtabstop=2
au BufEnter *.x set expandtab

au BufEnter *.als set syntax=alloy
au BufEnter *.als set shiftwidth=4
au BufEnter *.als set tabstop=4
