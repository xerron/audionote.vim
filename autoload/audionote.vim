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
let g:audionote#record_command =
      \ get(g:, 'audionote#record_command', 'arecord -f S16_LE -c1 -r8000 -t raw | speexenc - --vad ')
let g:audionote#play_command =
      \ get(g:, 'audionote#play_command', 'ogg123 ')
let g:audionote#aditional_play_command =
      \ get(g:, 'audionote#aditional_play_command', ' > /dev/null 2>&1 & ')



function! audionote#open(prefix, ...) 
  let postfix = get(a:000, 0, '')
  let filename = postfix == '' ?
        \ input('Audio Code: ', a:prefix) : a:prefix . postfix

  if filename != ''
    call audionote#_open(filename)
  endif
endfunction

function! audionote#open_immediately(filename) 
  call audionote#_open(a:filename)
endfunction

function! audionote#_open(filename)
  let filename = g:audionote#directory . strftime('/%Y/%m/') . a:filename . '.spx'
  let junk_dir = fnamemodify(filename, ':h')
  if !isdirectory(junk_dir)
    call mkdir(junk_dir, 'p')
  endif
  "arecord -f S16_LE -c1 -r8000 -t raw | speexenc - --vad salida.spx  
  let full_cmd = printf('!%s %s', g:audionote#record_command , filename)
  exec full_cmd
endfunction

function! audionote#_play(filename)
  "ogg123 ruta/archivo.spx
  let full_cmd = printf('!%s %s %s', g:audionote#play_command , a:filename , g:audionote#aditional_play_command)
  silent! exec full_cmd
endfunction

function! audionote#_record(filename)
  let filename = g:audionote#directory . strftime('/%Y/%m/') . a:filename . '.spx'
  let junk_dir = fnamemodify(filename, ':h')
  if !isdirectory(junk_dir)
    call mkdir(junk_dir, 'p')
  endif
  "arecord -f S16_LE -c1 -r8000 -t raw | speexenc - --vad salida.spx  
  let full_cmd = printf('!%s %s', g:audionote#record_command , filename)
  exec full_cmd
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
