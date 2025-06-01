" Single obsidian vimrc setup to be symlinked
nmap j zj
nmap k zk

set clipboard=unnamed

map s[ :surround_square_brackets<CR>
map s] :surround_square_brackets<CR>

exmap togglefold obcommand editor:toggle-fold
nmap za :togglefold<CR>
