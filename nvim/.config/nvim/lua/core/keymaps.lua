local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local mappings = {
  -- Normal mode
  {
    mode = "n",
    keys = {
      -- Better window navigation
      { "<C-h>", "<C-w>h" },
      { "<C-j>", "<C-w>j" },
      { "<C-k>", "<C-w>k" },
      { "<C-l>", "<C-w>l" },

      -- Resize with arrows
      { "<C-Up>", "<cmd>resize +2<CR>" },
      { "<C-Down>", "<cmd>resize -2<CR>" },
      { "<C-Left>", "<cmd>vertical resize -2<CR>" },
      { "<C-Right>", "<cmd>vertical resize +2<CR>" },

      -- Navigate buffers
      { "<S-l>", vim.cmd.bnext },
      { "<S-h>", vim.cmd.bprevious },

      -- Move text up and down
      { "<A-j>", ":m .+1<CR>==" },
      { "<A-k>", ":m .-2<CR>==" },

      -- Yank the rest of the line with "Y"
      { "Y", "y$" },

      -- C-u / C-d keep centered
      { "<C-d>", "<C-d>zz" },
      { "<C-u>", "<C-u>zz" },

      -- J keeps cursor in place
      { "J", "mzJ`z" },

      -- Search now keep cursor in the middle
      { "n", "nzzzv" },
      { "N", "Nzzzv" },
    },
  },
  -- Insert mode
  {
    mode = "i",
    keys = {
      -- Press jk fast to enter
      { "jk", "<ESC>" },

      -- Use CTRL to control the cursor in insert mode
      { "<C-h>", "<Left>" },
      { "<C-j>", "<Down>" },
      { "<C-k>", "<Up>" },
      { "<C-l>", "<Right>" },
    },
  },
  -- Visual mode
  {
    mode = "v",
    keys = {
      -- Stay in indent mode
      { "<", "<gv" },
      { ">", ">gv" },

      -- Move text up and down
      { "J", ":m '>+1<CR>gv=gv" },
      { "K", ":m '<-2<CR>gv=gv" },
    },
  },
}

for _, mapping in ipairs(mappings) do
  for _, key in ipairs(mapping.keys) do
    keymap(mapping.mode, key[1], key[2], opts)
  end
end
