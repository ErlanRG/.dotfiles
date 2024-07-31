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
set background=dark
set cmdheight=2
set completeopt=menuone,noselect
set conceallevel=0
set cursorline
:highlight Cursorline cterm=bold ctermbg=black
set expandtab
set fileencoding=utf-8
set formatoptions-=cro
set hidden
set hlsearch
set incsearch
set ignorecase
set iskeyword+=-
set laststatus=2
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
syntax on
if !has('gui_running')
    set t_Co=256
endif

colorscheme retrobox

" Remappings
let mapleader=" "

" Source .vimrc on save
autocmd! BufWritePost .vimrc source %

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
command! NumberLines call NumberLines()

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

nnoremap <silent> <leader>c :call CloseBuffer()<CR>
nnoremap <silent> <leader>e :vertical 25 Lex<CR>

nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> Y y$

nnoremap <silent> <leader>sv :vnew<CR>
nnoremap <silent> <leader>sh :new<CR>

nnoremap <silent> <S-l> :bnext<CR>
nnoremap <silent> <S-h> :bprevious<CR>

inoremap <silent> jk <Esc>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-j> <Down>
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-l> <Right>

vnoremap <silent> < <gv
vnoremap <silent> > >gv
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
