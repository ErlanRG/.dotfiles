local bufkill = require("utils").buf_kill
local builtin = require "telescope.builtin"
local formatting = require("utils").lsp_formatting
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
      { "<C-h>",      "<C-w>h" },
      { "<C-j>",      "<C-w>j" },
      { "<C-k>",      "<C-w>k" },
      { "<C-l>",      "<C-w>l" },

      -- Creating splits
      { "<Leader>vs", vim.cmd.vnew },
      { "<Leader>hs", vim.cmd.new },

      -- Save (actually, update)
      -- Like ":write", but only write when the buffer has been modified.
      { "<Leader>w",  vim.cmd.update },

      -- Resize with arrows
      { "<C-Up>",     "<cmd>resize +2<CR>" },
      { "<C-Down>",   "<cmd>resize -2<CR>" },
      { "<C-Left>",   "<cmd>vertical resize -2<CR>" },
      { "<C-Right>",  "<cmd>vertical resize +2<CR>" },

      -- Navigate buffers
      { "<S-l>",      vim.cmd.bnext },
      { "<S-h>",      vim.cmd.bprevious },

      -- Move text up and down
      { "<A-j>",      ":m .+1<CR>==" },
      { "<A-k>",      ":m .-2<CR>==" },

      -- Yank the rest of the line with "Y"
      { "Y",          "y$" },

      -- Telescope
      { "<Leader>ff", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>" },
      { "<Leader>fh", "<cmd>Telescope help_tags<CR>" },
      { "<Leader>fg", "<cmd>Telescope git_files<CR>" },
      { "<Leader>fb", "<cmd>Telescope buffers<CR>" },
      {
        "<Leader>fk",
        function()
          builtin.grep_string { search = vim.fn.input "Grep > " }
        end,
      },

      -- Git
      { "<Leader>gs", vim.cmd.G },

      -- Nvimtree
      { "<Leader>e",  vim.cmd.NvimTreeToggle },

      -- Lazy
      { "<Leader>ps", "<cmd>Lazy sync<CR>" },

      -- Autoformat
      { "<Leader>lf", formatting },
      { "<Leader>lF", vim.lsp.buf.format },

      -- C-u / C-d keep centered
      { "<C-d>",      "<C-d>zz" },
      { "<C-u>",      "<C-u>zz" },

      -- J keeps cursor in place
      { "J",          "mzJ`z" },

      -- Search now keep cursor in the middle
      { "n",          "nzzzv" },
      { "N",          "Nzzzv" },

      -- Not sure how to comment this one
      { "<leader>p",  '"_dP' },

      -- (Barbar) Order buffers
      { "<leader>bl", vim.cmd.BufferOrderByLanguage },
      { "<leader>bn", vim.cmd.BufferOrderByBufferNumber },

      -- Close buffer
      { "<leader>c",  bufkill },

      -- Trouble
      { "<leader>tr", vim.cmd.Trouble },

      -- Copilot
      { "<leader>]",  "<cmd>Copilot panel<CR>" },

      -- Dashboard
      { "<leader>;",  vim.cmd.Alpha },
    },
  },
  -- Insert mode
  {
    mode = "i",
    keys = {
      -- Press jk fast to enter
      { "jk",    "<ESC>" },

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
