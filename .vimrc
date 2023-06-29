set nocompatible
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
:highlight Cursorline cterm=bold ctermbg=black
filetype on
filetype plugin on
filetype indent on
set hlsearch
set ignorecase
set smartcase
set showmatch
set noswapfile
set incsearch
set scrolloff=8
set colorcolumn=80
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
nmap sj <C-w>j 
nmap sk <C-w>k 
nmap sh <C-w>h 
nmap sl <C-w>l 
nmap fe :Ex <CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', 
Plug 'iamcco/coc-actions', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile && yarn build'}

Plug 'iamcco/coc-actions', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'iamcco/coc-angular', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'junegunn/seoul256.vim'
Plug 'sainnhe/everforest'
Plug 'rhysd/vim-healthcheck'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'scrooloose/nerdtree'
call plug#end()



"runtime .vim/configs/coc-settings.vim

"nnoremap <SPACE> <Nop>

set background=dark
if has('termguicolors')
  set termguicolors
endif

colorscheme everforest
let g:ctrlp_custom_ignore = {
      \ 'dir':  'node_modules\|dist',
      \ }
set encoding=utf-8
set wildignore+=node_modules/**,dist/**
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set shortmess+=c
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Coc settings
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use K to show documentation in preview window
nnoremap <silent> I :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nmap R <Plug>(coc-rename)
xmap A <Plug>(coc-codeaction-selected)
nmap A <Plug>(coc-codeaction-selected)
nmap C <Plug>(coc-codeaction-cursor)
nmap K <Plug>(coc-codelens-action)
nmap \ :CocDiagnostics <CR> 
let mapleader=" "

function! GetSectionContents()
  return bufnr('%')
endfunction

call airline#parts#define_function('fun','GetSectionContents')

let g:airline_section_y = airline#section#create_right(['ffenc', 'fun'])

"popup
let g:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})

function OnBufferSelect(id, result)
  execute "b ".g:blist[a:result-1].bufnr 
endfunction  

function OpenPopUp()
  let g:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
  let l:bnames = []
  for l:item in g:blist
    "if empty(l:item.name) || l:item.hidden
    "  continue
    "endif
    call add(l:bnames,shellescape(l:item.name))
  endfor
  call popup_menu(l:bnames , #{title: "Buffers",
     \ callback: 'OnBufferSelect', border: [], padding:[1,1,1,1] })
endfunction

function ClosePopUp()
  popup_clear()
endfunction  

nmap <C-b> :call OpenPopUp() <CR>

function N12(command)
 execute "! npx -p node@12.16.1 -- yarn"." ".a:command
endfunction
  

function N16(command)
 execute "! npx -p node@16.14.0 -- yarn"." ".a:command
endfunction
  
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e41 q"
