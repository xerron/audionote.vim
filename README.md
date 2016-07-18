# audionote.vim

Add easy audio notes to Vim.  Voice Recorder

![unite - audio - gvim1_020](https://cloud.githubusercontent.com/assets/1724033/16904150/4a94631a-4c56-11e6-9de4-f6cf223a4bf3.png)

![sin nombre - gvim1_019](https://cloud.githubusercontent.com/assets/1724033/16904153/56d3b702-4c56-11e6-9eb5-a7dd1c80531b.png)

## Requeriment

Require [Unite.vim](https://github.com/Shougo/unite.vim)

[![Stories in Ready](https://badge.waffle.io/Shougo/unite.vim.png)](https://waffle.io/Shougo/unite.vim)  

### GNU/Linux

- ogg123 (sudo apt-get install install vorbis-tools) 
- speex (sudo apt-get install speex)
- alsamixer (arecord command)

I use speex for encode audio, very good for voice recorder.

### Windows

I hate windows but try configure global variables. 

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

