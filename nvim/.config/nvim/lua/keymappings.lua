local opt = {noremap = true, silent = true}

-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', opt)
vim.g.mapleader = ' '

-- Plugin keymappings
-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', opt)
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', opt)
vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<CR>', opt)
vim.api.nvim_set_keymap('n', '<Leader>fh', ':Telescope help_tags<CR>', opt)

-- NvimTree
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', opt)

-- Comments
vim.api.nvim_set_keymap('n', '<Leader>/', ':CommentToggle<CR>', opt)
vim.api.nvim_set_keymap('v', '<Leader>/', ':CommentToggle<CR>', opt)

-- PackerSync
vim.api.nvim_set_keymap('n', '<Leader>ps', ':PackerSync<CR>', opt)

-- Zen
vim.api.nvim_set_keymap('n', '<Leader>z', ':ZenMode<CR>', opt)


-- Close buffer
vim.api.nvim_set_keymap('n', '<Leader>c', ':bd<CR>', opt)

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opt)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opt)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opt)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opt)

-- Dashboard
vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', opt)

-- Others
vim.api.nvim_set_keymap('n', '<Leader>h', ':let @/=""<CR>', opt)

-- Better Indenting
vim.api.nvim_set_keymap('v', '<', '<gv', opt)
vim.api.nvim_set_keymap('v', '>', '>gv', opt)

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

-- Yank the rest of the line with "Y"
vim.api.nvim_set_keymap('n', 'Y', 'y$', opt)

-- Keeping it centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opt)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opt)
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', opt)

-- Undo brake points
vim.api.nvim_set_keymap('i', ',', ',<c-g>u', opt)
vim.api.nvim_set_keymap('i', '.', '.<c-g>u', opt)
vim.api.nvim_set_keymap('i', '!', '!<c-g>u', opt)
vim.api.nvim_set_keymap('i', '?', '?<c-g>u', opt)

-- Jumplist mutations
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', opt)
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', opt)
