""" Plugins

call plug#begin()

"" Lightline {{{
    Plug 'itchyny/lightline.vim'
    let g:lightline = { 'colorscheme': 'solarized', }
    function! LLToggleBackground()
        call ToggleBackground()
        runtime autoload/lightline/colorscheme/solarized.vim
        call lightline#colorscheme()
        call lightline#update() " not sure if this line is necessary
    endfunction
    noremap <silent> <leader>b :call LLToggleBackground()<cr>
"" }}}

"" Move until char changes {{{
    source ~/.vim/plugins/move_until_char_changes.vim
"" }}}

"" FZF {{{
"    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"    Plug 'junegunn/fzf.vim'
"    nmap <leader>f :FZF<CR>
"" }}}

"" coc {{{
"    if system("which node") != ""
"        Plug 'neoclide/coc.nvim', {'branch': 'release'}
"    
"        let g:coc_global_extensions = [
"        \ 'coc-explorer',
"        "\ 'coc-prettier',
"        "\ 'coc-ultisnips',
"        \ 'coc-diagnostic',
"        \ 'coc-sh',
"        \ 'coc-vimlsp',
"        \ 'coc-pyright',
"        \ 'coc-clangd',
"        \ 'coc-css',
"        \ 'coc-json',
"        "\ 'coc-tsserver',
"        "\ 'coc-eslint',
"        "\ 'coc-tslint-plugin',
"        "\ 'coc-emmet',
"        \ ]
"        
"        "" Highlight the symbol and its references when holding the cursor.
"        autocmd CursorHold * silent call CocActionAsync('highlight')
"    
"        " Use `[g` and `]g` to navigate diagnostics
"        " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"        nmap <silent> [g <Plug>(coc-diagnostic-prev)
"        nmap <silent> ]g <Plug>(coc-diagnostic-next)
"    
"        " GoTo code navigation.
"        nmap <silent> gd <Plug>(coc-definition)
"        nmap <silent> gy <Plug>(coc-type-definition)
"        nmap <silent> gi <Plug>(coc-implementation)
"        nmap <silent> gr <Plug>(coc-references)
"        
"        "" Use K to show documentation in preview window.
"        nnoremap <silent> K :call <SID>show_documentation()<CR>
"    
"        augroup mygroup
"        autocmd!
"        " Setup formatexpr specified filetype(s).
"        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"        " Update signature help on jump placeholder.
"        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"        augroup end
"    
"        function! s:show_documentation()
"            if (index(['vim','help'], &filetype) >= 0)
"                execute 'h '.expand('<cword>')
"            elseif (coc#rpc#ready())
"            call CocActionAsync('doHover')
"        else
"            execute '!' . &keywordprg . " " . expand('<cword>')
"        endif
"    endfunction
"endif
"" }}}

call plug#end()
