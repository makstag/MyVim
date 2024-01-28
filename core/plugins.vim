lua require "plugins"
lua require "colorizer".setup{}
lua require "config.support"

"asyncrun""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" automatically open quickfix window when AsyncRun command is executed
" set the quickfix window 10 lines height.
let g:asyncrun_open = 10

"ring the bell to notify you job finished
let g:asyncrun_bell = 1
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']

nnoremap <silent> <F4> :AsyncTask project-init<cr>
nnoremap <silent> <F6> :AsyncTask project-run<cr>
nnoremap <silent> <S-F6> :AsyncStop<cr>
nnoremap <silent> <F7> :AsyncTask project-build<cr>
nnoremap <silent> <F8> :AsyncTask project-clean<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""