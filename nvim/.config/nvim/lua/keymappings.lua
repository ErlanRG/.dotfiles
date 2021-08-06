-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- Plugin keymappings
-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fh', ':Telescope help_tags<CR>', {noremap = true, silent = true})

-- NvimTree
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- Comments
vim.api.nvim_set_keymap('n', '<Leader>/', ':CommentToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<Leader>/', ':CommentToggle<CR>', {noremap = true, silent = true})

-- PackerSync
vim.api.nvim_set_keymap('n', '<Leader>ps', ':PackerSync<CR>', {noremap = true, silent = true})

-- Zen
vim.api.nvim_set_keymap('n', '<Leader>z', ':ZenMode<CR>', {noremap = true, silent = true})


-- Close buffer
vim.api.nvim_set_keymap('n', '<Leader>c', ':bd<CR>', {noremap = true, silent = true})

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

-- Dashboard
vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', {noremap = true, silent = true})

-- Others
vim.api.nvim_set_keymap('n', '<Leader>h', ':let @/=""<CR>', {noremap = true, silent = true})

-- Better Indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

-- Yank the rest of the line with "Y"
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true, silent = true})

-- Keeping it centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', {noremap = true, silent = true})

-- Undo brake points
vim.api.nvim_set_keymap('i', ',', ',<c-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '.', '.<c-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '!', '!<c-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '?', '?<c-g>u', {noremap = true, silent = true})

-- Jumplist mutations
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})
