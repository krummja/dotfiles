filetype off
set rtp+=~/.vim/bundle/Vundle.vim


" PLUGINS
call vundle#begin()

" -----------------------------------------------------------
Plugin 'VundleVim/Vundle.vim'

Plugin 'chrisbra/Colorizer'
Plugin 'AlessandroYorba/Despacio'
Plugin 'AlessandroYorba/Sierra'
Plugin 'itchyny/lightline.vim'

Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'reedes/vim-thematic'
Plugin 'lervag/vimtex'
	let g:tex_flavor = 'latex'

Plugin 'vim-scripts/guicolorscheme.vim'

Plugin 'junegunn/goyo.vim'
nmap <F4> :Goyo 100%x100%<cr>

Plugin 'xuhdev/vim-latex-live-preview'
autocmd Filetype tex setl updatetime=1
	let g:livepreview_cursorhold_recompile 			= 0
	let g:livepreview_engine 						= 'xelatex'
	let g:livepreview_previewer 					= 'mupdf'
nmap <F5> :LLPStartPreview<cr>

" -----------------------------------------------------------

call vundle#end()
filetype plugin indent on
" END PLUGINS


" Color and Editor Options
"let g:sierra_Sunset = 1
"colorscheme sierra

hi clear Normal
hi Normal guifg=#ffffff guibg=#800000
hi clear Error
hi clear Conceal
hi Title cterm=bold
hi FoldColumn ctermfg=240
hi clear SignColumn
if !has('gui_running')
		set t_Co=256
endif

" Settings
set scl=yes
set nocompatible
set laststatus=2
set noshowmode
set tabstop=4

" Remaps
noremap <silent> <D-9> :<C-u>ThematicNarrow<cr>
noremap <silent> <D-0> :<C-u>ThematicWiden<cr>
inoremap <silent> <D-9> :<C-u>ThematicNarrow<cr>
inoremap <silent> <D-0> :<C-u>ThematicWiden<cr>

nnoremap <S-F11> <ESC>:set hls! hls?<cr>
inoremap <S-F11> <ESC>:set hls! hls?<cr>
vnoremap <S-F11> <ESC>:set hls! hls?<cr>

set mouse=a "enables mouse click
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>
