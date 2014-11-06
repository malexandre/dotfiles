" General configuration
set number
set ruler
set autoread
set so=3
set cmdheight=2
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Auto indentation
set autoindent
set smartindent
set showmatch
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
filetype on
filetype plugin indent on

" Formatting
set formatoptions=tq
set textwidth=120

" Java
let java_minilines=100
let java_highlight_java_lang_ids=1
imap <leader>so System.out.println();<left><left>
imap <leader>no Notification.setMessage();<left><left>
imap <leader>ne Notification.setError();<left><left>

" Manual re-indentation
noremap < <gv
noremap > >gv

" Common shortcut
noremap <c-a> ggVG
inoremap <c-z> <c-o>ui

" indentation is 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4

" Up and Down navigate through multi-lines
map k gk
map j gj
map <Up> gk
map <Down> gj

" Search highlight can be disable with Enter
set hlsearch
set incsearch
set ignorecase
set smartcase
:nnoremap <CR> :nohlsearch<CR>/<BS><CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Tab management
map <C-T> :tabnew<CR>:edit 
map <C-O> :tabfind 
noremap <S-Tab> gt

" Smart backspace
set backspace=indent,eol,start

" Status line
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Split window arrow navigation
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Taglist
let Tlist_Inc_Winwidth=0
let Tlist_GainFocus_On_ToggleOpen=1
noremap <silent> <F3> :TlistToggle<CR>

" NerdTree
let NERDTreeQuitOnOpen=1
noremap <silent> <F2> :NERDTreeToggle<CR>

" Syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
