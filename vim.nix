{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (neovim.override {
      vimAlias = true;
      viAlias = true;

      configure = {
        customRC = ''
filetype plugin indent on
let mapleader = ','
let $MYVIMRC = '~/nix-config/nvim/default.nix'

set exrc            " allow for directory-specific vim configs
set tabstop=2       " number of spaces a tab is displayed as
set softtabstop=2   " number of spaces in a tab while editing
set shiftwidth=2    " set indent as 2 spaces
set expandtab       " convert tabs to spaces
set smarttab        " insert tabs based on shiftwidth, not tab size
set shiftround      " use shiftwidth to determine tabbing w/'<' and '>' commands

set autoindent      " always auto-indent
set copyindent      " copy the previous line's indent on autoindent

set number          " line numbers
set relativenumber  " relative line numbers
syntax enable       " colors for syntax
set showcmd         " show last command in bottom bar
set cursorline      " highlights current line
set wildmenu        " show all autocomplete options (e.g. :e)
set showmatch       " show matching brackets
set lazyredraw      " only redraw when something has changed

set hidden          " hide previously open buffers rather than closing them (e.g. :e)

set nobackup        " don't create backup files
set nowritebackup   " don't create write-backup files
set noswapfile      " don't create backup swap files

set updatetime=300  " shorter update time for VIM and plugins

noremap <C-N> :NERDTreeToggle<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<CR>

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=dark             " dark colorscheme
colorscheme NeoSolarized        " solarized colorscheme
let g:solarized_termtrans=1     " transparency
highlight Visual cterm=reverse  " forget why this works
" ctermbg=NONE                    " same here

let g:lightline = { 'colorscheme': 'solarized' }  " solarized colorscheme for lightline

set incsearch       " search as characters are entered
set hlsearch        " highlight matches
set ignorecase      " ignore case for search
set smartcase       " ignore case if search pattern all lowercase, case-sensitive otherwise

" move vertically by visual line--don't skip screen-wrapped lines
nnoremap j gj
nnoremap k gk

nnoremap dr 0d$

" allows backspace in insert mode to delete all characters
" including tabs, eol, and where the cursor started
" seel :help 'backspace'
set backspace=indent,eol,start

augroup commentary
  autocmd!
  autocmd FileType racket setlocal commentstring=;;\ %s
augroup END

" custom header for vim screen, inspired by DOOM emacs

let g:ascii = [
  \ "=================     ===============     ===============   ========  ========",
  \ "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
  \ "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
  \ "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
  \ "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
  \ "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
  \ "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
  \ "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||", 
  \ "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
  \ "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
  \ "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
  \ "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
  \ "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
  \ "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
  \ "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||",
  \ "||.=='    _-'                                                     `' |  /==.||",
  \ "=='    _-'                                                            \\/   `==",
  \ "\\   _-'                                                                `-_   /",
  \ "`'''                                                                      ``'",
  \]

" WARNING: the triple-single quote in the bottom left corner of the logo is a Nix escape sequence for double-single quotes.

  " \ ["  The object-oriented model makes it easy to build up programs by accretion.\n     What this often means\n, in practice, is that it\n provides a structures way to write spaghetti\n code."]
let g:startify_custom_header_quotes = [
  \ ["                                Welcome to VIM"],
  \ ["                                Welcome to HELL"],
  \ ["                          Correct answer, zero points"],
  \ ["                        I'll give you a hint: left paren"],
  \ ["                                     oopsah"],
  \]

let g:startify_custom_header = 'startify#center(g:ascii + g:startify#fortune#quote())'

let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':    ['<BS>'],
  \ 'PrtCurleft()': ['<C-[>', '<left>', '<C-^>'],
  \ 'PrtCurRight()': ['<C-]>', '<right>'],
  \ 'ToggleType(1)': ['<C-L>', '<C-Up>'],
  \ 'ToggleType(-1)': ['<C-H>', '<C-Down>'],
  \ }

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" Terminal config
tnoremap <Esc> <C-\><C-N>
tnoremap <C-W> <Esc><C-W>
  
        '';
        packages.myVimPackage = with pkgs.vimPlugins; {
          start = [
            vim-nix
            ctrlp-vim
            nerdtree
            lightline-vim
            vim-startify
            vim-polyglot
            vim-fugitive
            vim-commentary
            NeoSolarized
            coc-nvim
            coc-tsserver
          ];
          
          opt = [];
        };
      };
    })
  ];
}
