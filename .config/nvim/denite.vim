autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d       denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q       denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>   denite#do_map('quit')
  nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'

  call denite#do_map('open_filter_buffer')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap    <silent><buffer>       <Esc>   <CR>q
  noremap <silent><buffer>       <Esc>   <CR>q
endfunction

call denite#custom#source(
  \ 'file/rec', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])

" Change default action.
call denite#custom#kind('file', 'default_action', 'split')

let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.5
call denite#custom#option('default', {
  \ 'split': 'floating',
  \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
  \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
  \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
  \ 'winrow': float2nr(&lines - (&lines * s:denite_win_height_percent) - 5),
  \ })

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
  \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#var('file/rec', 'command',
  \ ['find', '-L', ':directory',
  \ '-path', '*/.svn/*', '-prune', '-o',
  \ '-path', '*/.git/*', '-prune', '-o',
  \ '-path', '*/node_modules/*', '-prune', '-o',
  \ '-type', 'l', '-print', '-o',
  \ '-type', 'f', '-print'])

" nnoremap <silent> <Leader>f :Denite -auto-action=preview -start-filter -prompt=$
"   \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
nnoremap <silent> <Leader>b :Denite buffer<CR>
nnoremap <silent> <Leader>y :Denite neoyank<CR>
nnoremap <silent> <Leader>s :Denite -auto-action=preview grep<CR>
nnoremap <silent> <Leader>o :Denite outline<CR>
