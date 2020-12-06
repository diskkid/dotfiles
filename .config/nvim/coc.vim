call coc#add_extension(
      \ 'coc-diagnostic',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-rust-analyzer',
      \ 'coc-solargraph',
      \ 'coc-tsserver',
      \ )


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>rf <Plug>(coc-format)


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


nnoremap [list] <Nop>
nmap <Leader>l [list]
nnoremap <silent> [list]l :CocList<CR>
nnoremap <silent> [list]f :CocList -A --tab files<CR>
nnoremap <silent> [list]g :CocList grep<CR>
