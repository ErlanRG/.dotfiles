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
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 2,
    termguicolors = true,
    timeoutlen = 1000,
    undofile = true,
    updatetime = 300,
    wrap = false,
    writebackup = false,
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "set winbar=%=%m%f"
vim.cmd [[set iskeyword+=-]]
