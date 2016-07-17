let s:kind = {
      \ 'name': 'audio',
      \ 'default_action': 'execute',
      \ 'action_table': {},
      \ 'parents': [],
      \ }
let s:kind.action_table.execute = {
      \ 'is_selectable': 1,
      \ }
function! s:kind.action_table.execute.func(candidates)
  if len(a:candidates) != 1
    echo "candidates must be only one"
    return
  endif
  call audionote#_play(a:candidates[0].action__path)
  " plugin path
  " let s:plugin_path = expand('<sfile>:p:h:h') 
  " install vorbis-tools
  " para mp3
  "sudo apt-get install mpg123  para usar play command
  "or 
  "sudo apt-get install sox   para usar play command
  "let s:play_cmd = 'ogg123'
  "let full_cmd = printf('!%s %s > /dev/null 2>&1 &', s:play_cmd, a:candidates[0].action__path)
  " se puede usar:
  " speexdec recording-20140924140238.spx output.wav
  " para convertir el archivo a wav
  "echo full_cmd
  "silent! exec full_cmd
endfunction

let s:kind.action_table.new = {
      \ 'is_selectable': 1,
      \ }

function! s:kind.action_table.new.func(candidates)
  call audionote#_record(a:candidates[0].word)
endfunction

function! unite#kinds#audio#define()
  return s:kind
endfunction
