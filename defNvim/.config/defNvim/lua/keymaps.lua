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
keymap("n", "<Leader>vs", vim.cmd.vnew, opts)
keymap("n", "<Leader>hs", vim.cmd.new, opts)

-- Save (actually, update)
-- Like ":write", but only write when the buffer has been modified.
keymap("n", "<Leader>w", vim.cmd.update, opts)

-- Lazy
keymap("n", "<Leader>ps", "<cmd>Lazy sync<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", vim.cmd.bnext, opts)
keymap("n", "<S-h>", vim.cmd.bprevious, opts)

-- Close buffers
keymap("n", "<Leader>c", require("utils").buf_kill, opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Others
-- Yank the rest of the line with "Y"
keymap("n", "Y", "y$", opts)

-- Explorer
keymap("n", "<Leader>e", vim.cmd.Ex, opts)

-- C-u / C-d keep centered
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- J keeps cursor in place
keymap("n", "J", "mzJ`z", opts)

-- Search now keep cursor in the middle
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Not sure how to comment this one
keymap("x", "<leader>p", '"_dP', opts)
