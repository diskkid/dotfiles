let g:ale_update_tagstack = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_c_parse_compile_commands = 1
let g:ale_c_parse_makefile = 1
let g:ale_c_clang_options = '-L. -I. -std=c11 -Wall'
let g:ale_c_clangd_options = '-background-index'

let g:ale_linters = {
  \ 'c':      ['clangd'],
  \ 'cpp':    ['clangd'],
  \ 'go':     ['gofmt', 'golint', 'go vet'],
  \ 'python': ['pyls'],
  \ 'rust':   ['rls', 'cargo'],
  \ }

let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \ '*':      ['remove_trailing_lines', 'trim_whitespace'],
  \ 'c':      ['clang-format'],
  \ 'cpp':    ['clang-format'],
  \ 'go':     ['gofmt', 'goimports'],
  \ 'python': ['autopep8'],
  \ 'rust':   ['rustfmt'],
  \ }
