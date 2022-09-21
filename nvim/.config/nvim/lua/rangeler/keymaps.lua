local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal mode
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Creating splits
keymap("n", "<Leader>vs", "<cmd>vnew<CR>", opts)
keymap("n", "<Leader>hs", "<cmd>new<CR>", opts)

-- Save
keymap("n", "<Leader>w", "<cmd>w<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

-- Close buffers
keymap("n", "<Leader>c", "<cmd>bd<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", "<cmd>move '>+1<CR>gv-gv", opts)
keymap("x", "K", "<cmd>move '<-2<CR>gv-gv", opts)
keymap("v", "<A-j>", "<cmd>m .+1<CR>==", opts)
keymap("v", "<A-k>", "<cmd>m .-2<CR>==", opts)
keymap("x", "<A-j>", "<cmd>move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", "<cmd>move '<-2<CR>gv-gv", opts)

-- Others
-- Yank the rest of the line with "Y"
keymap("n", "Y", "y$", opts)

-- Plugin keymaps
-- Telescope
keymap("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<Leader>fk", "<cmd>Telescope keymaps<CR>", opts)
keymap("n", "<Leader>fg", "<cmd>Telescope git_commits<CR>", opts)
keymap("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", opts)

-- Nvimtree
keymap("n", "<Leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- Tablemode
keymap("x", "<Leader>tb", "<cmd>Tableize<CR>", opts)

-- Packer
keymap("n", "<Leader>ps", "<cmd>PackerSync<CR>", opts)
