local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Close buffer
keymap("n", "<Leader>c", ":bd<CR>", opts)

-- Others
-- keymap('n', '<Leader>h', ':let @/=""<CR>', opts)

-- Yank the rest of the line with "Y"
vim.api.nvim_set_keymap('n', 'Y', 'y$', opts)

-- Keeping it centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts)
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', opts)

-- Undo brake points
vim.api.nvim_set_keymap('i', ',', ',<c-g>u', opts)
vim.api.nvim_set_keymap('i', '.', '.<c-g>u', opts)
vim.api.nvim_set_keymap('i', '!', '!<c-g>u', opts)
vim.api.nvim_set_keymap('i', '?', '?<c-g>u', opts)

-- Jumplist mutations
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', opts)
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', opts)

-- Plugin kemaps

-- Telescope
keymap("n", "<leader>tf", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>th", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>tk", "<cmd>Telescope keymaps<CR>", opts)
keymap("n", "<leader>tn", "<cmd>Telescope find_files cwd=~/.config/nvim/<CR>", opts)
keymap("n", "<leader>tg", "<cmd>Telescope git_commits<CR>", opts)

-- NvimTree 
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- ToggleTerm
keymap("n", "<leader>tt", ":ToggleTerm<CR>", opts)
