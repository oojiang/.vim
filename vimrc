""" Oliver Jiang's vim config

"" General {{{
    set history=1000
    set textwidth=120 " wrap lines after 120 characters

    set clipboard+=unnamed " share system keyboard

    set path+=** "Search down into subfolders

    set timeoutlen=1000
    set ttimeoutlen=5

    "" Searching
    set ignorecase  " case insensitive searching
    set smartcase " case-sensitive if expression contains a capital letter
    set hlsearch  " highlight search results
    set incsearch " incremental search, like modern browsers
    set nolazyredraw  " don't redraw while executing macros

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500
"" }}}

"" Appearance {{{
    "" Line Numbers
    set relativenumber " relative line numbers
    autocmd FileType * set relativenumber

    "" Misc
    set cursorline
    set wrap  " turn on line wrapping
    set wrapmargin=8 " wrap lines when coming within n characters from the side
    set linebreak " set soft wrapping
    "set showbreak=↪
    set autoindent " automatically set indent of new line
    set ttyfast " faster redrawing
    set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff " diff mode settings
    set laststatus=2 " always show the status line
    set so=3 " set 3 lines to the cursors - when moving vertical
    set wildmenu " enhanced command line completion
    set hidden " current buffer can be put into background
    set showcmd " show incomplete commands
    set wildmode=list:longest " complete files like a shell
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of a second to blink
    set updatetime=300
    set signcolumn=yes
    "set shortmess+=c

    "" Cursor (from https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes)
    let &t_SI.="\e[6 q" "SI = INSERT mode
    let &t_SR.="\e[4 q" "SR = REPLACE mode
    let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)
    
    "  1 -> blinking block
    "  2 -> solid block 
    "  3 -> blinking underscore
    "  4 -> solid underscore
    "  5 -> blinking vertical bar
    "  6 -> solid vertical bar
    
    "" Tab control
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=4 " number of visual spaces per TAB
    set softtabstop=4 " number of spaces in tab when editing
    set shiftwidth=4  " number of spaces that < and > insert and delete.
    set shiftround  " round indent to a multiple of 'shiftwidth'
    set expandtab " tabs are spaces

    "" cold folding settings
    set foldmethod=indent " fold based on indent
    set foldlevelstart=99
    set foldnestmax=20 "deepest fold is 20 levels
    set nofoldenable " don't fold by default
    set foldlevel=1

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors

    if &term =~ '256color'
        " disable background color erase
        set t_ut=""
    endif
""}}}

"" General Mappings {{{
    "" leader key
    let mapleader = "\<Space>" 

    "" clear highlighted search
    map <leader>n :noh<cr>

    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    "" switch between current and last buffer
    nmap <leader><tab> <c-^>

    "" enable . command in visual mode
    vnoremap . :normal .<cr>

    "" scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>
"" }}}

"" Plugins {{{
    call plug#begin()
    "" Load colorschemes
    Plug 'rafi/awesome-vim-colorschemes'

    "" Lightline
    Plug 'itchyny/lightline.vim'
    "let g:lightline = { 'colorscheme': 'solarized', }

    "" FZF {{{
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        map <leader>f :FZF<CR>
    "" }}}

    "" coc {{{
        if system("which node") != ""
            Plug 'neoclide/coc.nvim', {'branch': 'release'}

            let g:coc_global_extensions = [
            \ 'coc-explorer',
            "\ 'coc-prettier',
            "\ 'coc-ultisnips',
            \ 'coc-diagnostic',
            \ 'coc-sh',
            \ 'coc-vimlsp',
            \ 'coc-pyright',
            \ 'coc-clangd',
            \ 'coc-css',
            \ 'coc-json',
            "\ 'coc-tsserver',
            "\ 'coc-eslint',
            "\ 'coc-tslint-plugin',
            "\ 'coc-emmet',
            \ ]
            
            "" Highlight the symbol and its references when holding the cursor.
            autocmd CursorHold * silent call CocActionAsync('highlight')

            " Use `[g` and `]g` to navigate diagnostics
            " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
            nmap <silent> [g <Plug>(coc-diagnostic-prev)
            nmap <silent> ]g <Plug>(coc-diagnostic-next)

            " GoTo code navigation.
            nmap <silent> gd <Plug>(coc-definition)
            nmap <silent> gy <Plug>(coc-type-definition)
            nmap <silent> gi <Plug>(coc-implementation)
            nmap <silent> gr <Plug>(coc-references)
            
            "" Use K to show documentation in preview window.
            nnoremap <silent> K :call <SID>show_documentation()<CR>

            augroup mygroup
            autocmd!
            " Setup formatexpr specified filetype(s).
            autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
            " Update signature help on jump placeholder.
            autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
            augroup end

            function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            elseif (coc#rpc#ready())
                call CocActionAsync('doHover')
            else
                execute '!' . &keywordprg . " " . expand('<cword>')
            endif
            endfunction
        endif
    "" }}}

    "" File Browsing {{
        Plug 'preservim/nerdtree'
        let g:NERDTreeHijackNetrw = 1
        nmap <leader>j :edit .<cr>
        if system("which node") == ""
            nmap <leader>k :NERDTreeToggle<cr>
        else
            nmap <leader>k :CocCommand explorer<cr>
        endif
    ""}}
    call plug#end()
"" }}}

"" Colorscheme {{{
    " This call must happen after the plug#end() call to ensure
    " that the colorschemes have been loaded   
    colorscheme solarized8_flat
    set background=light
    syntax enable
    filetype plugin indent on
    "" make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=19 guifg=#333333
    highlight NonText ctermfg=19 guifg=#333333
"" }}}
