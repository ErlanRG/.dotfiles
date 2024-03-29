local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 2,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  cursorline = true,
  expandtab = true,
  fileencoding = "utf-8",
  hlsearch = false,
  ignorecase = true,
  laststatus = 3,
  mouse = "a",
  number = true,
  numberwidth = 2,
  pumheight = 10,
  relativenumber = true,
  scrolloff = 8,
  shiftwidth = 2,
  showtabline = 2,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 4,
  termguicolors = true,
  timeoutlen = 1000,
  undofile = true,
  updatetime = 300,
  whichwrap = "bs<>[]hl",
  wrap = false,
  writebackup = false,
}

vim.opt.shortmess:append "c"
vim.opt.iskeyword:append "-"
vim.opt.formatoptions:remove { "c", "r", "o" }

for k, v in pairs(options) do
  vim.opt[k] = v
end
