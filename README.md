# audionote.vim

Add easy audio notes to Vim.  Voice Recorder

## Install

```vim
NeoBundle 'xerron/audionote.vim'
```

or

```vim
NeoBundleLazy 'xerron/audionote.vim', {'autoload':{'commands':'Audionote','unite_sources':['audionote','audionote/new']}}
```

```vim

if s:is_windows
    let g:audionote#directory=expand("$VIM/.cache/audionote")
else
    let g:audionote#directory=expand("~/Dropbox/Audios")
endif

nnoremap <silent> [unite]v :<C-u>Unite -auto-resize -buffer-name=audio audionote audionote/new<cr>

```

## Configure 

```vim
let g:audionote#directory=expand("~/Dropbox/Audios")
"e.g: record_command filename
let g:audionote#record_command='arecord -f S16_LE -c1 -r8000 -t raw | speexenc - --vad '
"e.g: play_command filename aditional_play_command
let g:audionote#play_command='ogg123 '
let g:audionote#aditional_play_command=' > /dev/null 2>&1 & '
```

## Use

### Add Audionote:

:Audionote

or

[unite]v and choise filename.

### Play Audionote

[unite]v choise and <cr>

## Licence

MIT.

