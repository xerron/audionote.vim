"=============================================================================
" FILE: audionote.vim
" AUTHOR: Edwin Mauel Cerrón Angeles <xerron.angels@gmail.com>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Version: 1.0, for Vim 7.4
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

let g:audionote#directory =
      \ get(g:, 'audionote#directory', $HOME . '/.cache/audionote')
let g:audionote#edit_command =
      \ get(g:, 'audionote#edit_command', 'edit')

function! audionote#open(prefix, ...) 
  let postfix = get(a:000, 0, '')
  let filename = postfix == '' ?
        \ input('Junk Code: ', a:prefix) : a:prefix . postfix

  if filename != ''
    "echoerr "no pasa por aqui"
    call audionote#_open(filename)
  endif
endfunction

function! audionote#open_immediately(filename) 
  call audionote#_open(a:filename)
endfunction

function! audionote#_open(filename)
  let filename = g:audionote#directory . strftime('/%Y/%m/') . a:filename
  let junk_dir = fnamemodify(filename, ':h')
  if !isdirectory(junk_dir)
    call mkdir(junk_dir, 'p')
  endif

  "execute g:audionote#edit_command fnameescape(filename)
  echo "holaaaaa"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
