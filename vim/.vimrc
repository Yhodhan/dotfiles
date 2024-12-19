nmap fn :tabn<CR>
nmap fp :tabp<CR>
nmap ff :Ex<CR>
nmap gh 0
nmap gl $
nmap mm %
nmap md d%
nmap ge GG 
nmap vv :w<CR>
nmap qq :q!<CR>

vmap gh 0
vmap gl $
vmap mm %
vmap md d%
vmap ge GG 

let &t_SI = "\e[6 q"    " changes curor to thin line on insert

let &t_EI = "\e[2 q"    " changes cursor to block on insert end
 
syntax enable on
set relativenumber
