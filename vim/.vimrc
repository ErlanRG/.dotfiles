" Vim config file

" Options
filetype plugin indent on
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
  else
    set clipboard=unnamed
  endif
endif
set autoread
au FocusGained,BufEnter * silent! checktime
set background=dark
set cmdheight=2
set completeopt=menuone,noselect
set conceallevel=0
set cursorline
:highlight Cursorline cterm=bold ctermbg=black
set expandtab
set fileencoding=utf-8
set fileformats=unix,dos,mac
set formatoptions-=cro
set hidden
set hlsearch
set ignorecase
set incsearch
set iskeyword+=-
set laststatus=2
set magic
set mouse=a
set nobackup
set noswapfile
set nowrap
set nowritebackup
set number
set numberwidth=2
set pumheight=10
set relativenumber
set scrolloff=8
set shiftwidth=4
set shortmess+=c
set showmatch
set showmode
set showtabline=3
set signcolumn=yes
set smartcase
set smartindent
set spell
set splitbelow
set splitright
set tabpagemax=15
set tabstop=4
set termguicolors
set timeoutlen=1000
set undofile
set updatetime=300
set whichwrap+=b,s,<,>,[,],h,l
set wildchar=<TAB>
set wildmenu
syntax on
if !has('gui_running')
    set t_Co=256
endif

colorscheme retrobox

" Source .vimrc on save
augroup vimrc
  autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
augroup END

" Netrw settings
let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_localcopydircmd = 'cp -r'
hi! link netwMarkFile Search

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Format the status line
set statusline=\%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Delete trailing white space on save, useful for some filetypes ;)
function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

" Delete extra spaces on save
if has("autocmd")
    autocmd BufWritePre * :call CleanExtraSpaces()
endif

" Remappings
let mapleader=" "

" Close buffer confirmation
function! CloseBuffer()
  " Check if the current buffer has been modified
  if &modified
    " Ask the user to save the buffer if it's modified
    let l:choice = confirm("Buffer has unsaved changes. Save before closing?", "&Yes\n&No\n&Cancel", 1)
    if l:choice == 1
      " Save the buffer and close it if it's no longer modified
      write
      if !&modified
        bdelete
      endif
    elseif l:choice == 2
      " Close the buffer without saving
      bdelete!
    endif
  else
    " Close the buffer if it's not modified
    bdelete
  endif
endfunction

" For PxPlus
function! NumberLines()
  " Get the number of lines in the buffer
  let l:num_lines = line('$')

  " Variable to store the current line number
  let l:current_number = 10

  " Loop through each line
  for l:i in range(1, l:num_lines)
    " Get the current line content
    let l:line_content = getline(l:i)

    " Skip empty lines
    if len(trim(l:line_content)) == 0
        continue
    endif

    " Check if the line already has a number
    if l:line_content =~ '^\d\{4\}\s'
      " Extract the existing number
      let l:existing_number = str2nr(matchstr(l:line_content, '^\d\{4\}'))
      " Remove the existing number
      let l:line_content = matchstr(l:line_content, '^\d\{4\}\s\zs.*')

      " Update current number to the maximum of the existing number or the current number
      if l:existing_number > l:current_number
          let l:current_number = l:existing_number
      endif
    endif

    " Format the current number with leading zeros
    let l:line_number = printf('%04d', l:current_number)

    " Combine line number and content
    let l:new_line_content = l:line_number . ' ' . l:line_content

    " Set the new line content
    call setline(l:i, l:new_line_content)

    " Increment the current number by 10 for the next line
    let l:current_number += 10
  endfor
endfunction

" Normal mode
nnoremap <silent> <leader>nl :call NumberLines()<CR>
nnoremap <silent> <leader>c :call CloseBuffer()<CR>
nnoremap <silent> <leader>e :vertical 25 Lex<CR>

nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

nnoremap <silent> <C-A> ggVG
nnoremap <silent> <leader><CR> :nohl<CR>
nnoremap <silent> <leader>w :w!<CR>
nnoremap <silent> Y y$

nnoremap <silent> <leader>sv :vnew<CR>
nnoremap <silent> <leader>sh :new<CR>

nnoremap <silent> <S-l> :bnext<CR>
nnoremap <silent> <S-h> :bprevious<CR>

nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Insert mode
inoremap <silent> jk <Esc>

inoremap <silent> <C-h> <Left>
inoremap <silent> <C-j> <Down>
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-l> <Right>

" Visual mode
vnoremap <silent> < <gv
vnoremap <silent> > >gv
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
