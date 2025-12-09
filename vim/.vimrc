syntax enable on

nmap fn :tabn<CR>
nmap fp :tabp<CR>
nmap gh 0
nmap ff :Ex<CR>
nmap gl $
nmap mm %
nmap md d%
nmap ge GG 
nmap vv :w<CR>
nmap sp :sp<CR>
nmap vp :vsp<CR>
nmap qq :exit<CR>

vmap gh 0
vmap gl $
vmap mm %
vmap md d%
vmap ge GG 

let &t_SI = "\e[6 q"    " changes curor to thin line on insert

let &t_EI = "\e[2 q"    " changes cursor to block on insert end
 
set number relativenumber
set t_vb=
set backspace=indent,eol,start

call plug#begin()

" List your plugins here
Plug 'sainnhe/everforest'

call plug#end()

 " Important!!
if has('termguicolors')
	set termguicolors
endif

" For dark version.
set background=dark

" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
        " Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'soft'

        " For better performance
let g:everforest_better_performance = 1

color everforest
