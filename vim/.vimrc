syntax enable on
color desert

nmap fn :tabn<CR>
nmap fp :tabp<CR>
nmap gh 0
nmap ff :Ex<CR>
nmap gl $
nmap mm %
nmap md d%
nmap ge GG 
nmap vv :w<CR>

vmap gh 0
vmap gl $
vmap mm %
vmap md d%
vmap ge GG 

let &t_ti .= "\e[2 q"   " cursor when vim starts

let &t_SI = "\e[6 q"    " changes curor to thin line on insert

let &t_EI = "\e[2 q"    " changes cursor to block on insert end

set number relativenumber
set t_vb=
