"=============================================================================
" FILE: audionote.vim
" AUTHOR:  Edwin Manuel Cerrón Angeles <xerron.angels@gmail.com>
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
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#audionote#define()
  return [s:source_audionote, s:source_audionote_new]
endfunction

let s:source_audionote = {
      \ 'name' : 'audionote',
      \ 'description' : 'candidates from audionotes',
      \ 'max_candidates' : 30,
      \ 'action_table' : {},
      \ }

" Lista los audios
function! s:source_audionote.gather_candidates(args, context) 
  let _ = map(filter(split(glob(g:audionote#directory . '/**'), '\n'),
        \  'filereadable(v:val)'), "{
        \ 'word' : fnamemodify(v:val, ':t'),
        \ 'kind' : 'audio',
        \ 'action__path' : unite#util#substitute_path_separator(v:val),
        \ }
        \")

  return unite#util#sort_by(_, '-getftime(v:val.action__path)')
endfunction

let s:source_audionote_new = {
      \ 'name' : 'audionote/new',
      \ 'description' : 'new candidates in audionote',
      \ 'action_table' : {},
      \ 'default_action' : {'audio': 'new' },
      \ }

" crea un nuevo audio
function! s:source_audionote_new.change_candidates(args, context) 
  let junk_dir = g:audionote#directory . strftime('/%Y/%m')
  if !isdirectory(junk_dir)
    call mkdir(junk_dir, 'p')
  endif

  let filename = unite#util#substitute_path_separator(
        \ junk_dir . strftime('/%Y-%m-%d-%H%M%S.') . a:context.input)
  if filereadable(filename)
    return []
  endif

  let _ = map([filename], "{
        \ 'word' : fnamemodify(v:val, ':t'),
        \ 'abbr' : '[new audio] ' . fnamemodify(v:val, ':t'),
        \ 'kind' : 'audio',
        \ 'action__path' : v:val,
        \ }
        \")

  return _
endfunction

let s:source_audionote.action_table.delete = {
      \ 'description' : 'delete files',
      \ 'is_quit' : 0,
      \ 'is_invalidate_cache' : 1,
      \ 'is_selectable' : 1,
      \}

" borrar
function! s:source_audionote.action_table.delete.func(candidates) 
  if unite#util#input_yesno('Really force delete files?')
    for candidate in a:candidates
      call delete(candidate.action__path)
    endfor
  endif
endfunction

let s:source_audionote.action_table.unite__new_candidate = {
      \ 'description' : 'create a new audionote',
      \ 'is_listed' : 0,
      \}

" create new
function! s:source_audionote.action_table.unite__new_candidate.func(candidate) 
  "call audionote#open(strftime('%Y-%m-%d-%H%M%S.'))
  echo "Sex Esto esta dentro de autoload/unite/source/audionote.vim"
endfunction

let s:source_audionote_new.action_table.unite__new_candidate =
      \ deepcopy(s:source_audionote.action_table.unite__new_candidate)

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
