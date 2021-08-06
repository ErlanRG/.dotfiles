local cmd = vim.cmd
local opt = vim.o

cmd('syntax on')
cmd('set nowrap')
cmd('set ts=4')
cmd('set sw=4')
cmd('set expandtab')
cmd('set number')
cmd('set relativenumber')
cmd('set smartindent')
cmd('set nohlsearch')
cmd('filetype plugin on')
cmd('colorscheme onedark')

opt.completeopt = "menuone,noselect" -- Required by nvim-compe
opt.fileencoding = "UTF-8"
opt.cmdheight = 2
opt.pumheight = 10
opt.mouse = "a"
opt.cursorline = true
opt.showtabline = 2
opt.termguicolors = true
opt.showmode = false
opt.backup = false
opt.writebackup = false
opt.swapfile = false
-- opt.undodir = ~/.undo/undo
opt.undofile = true
opt.signcolumn = "yes"
opt.updatetime = 300
opt.clipboard = "unnamedplus"
opt.guifont = "FiraCode Nerd Font:h17"
