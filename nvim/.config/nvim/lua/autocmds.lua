local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

--[[ General settings ]]
local GeneralSettings = augroup("GeneralSettings", { clear = true })
autocmd("FileType", {
  pattern = { "qf", "help", "man", "lspinfo", "fugitive" },
  group = GeneralSettings,
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>:close<CR>", { buffer = args.buf })
  end,
})

autocmd("BufWinEnter", {
  pattern = "*",
  group = GeneralSettings,
  command = "set formatoptions-=cro",
})

autocmd("FileType", {
  pattern = "qf",
  group = GeneralSettings,
  command = "set nobuflisted",
})

--[[ Git ]]
local Git = augroup("GitGroup", { clear = true })
autocmd("FileType", {
  pattern = "gitcommit",
  group = Git,
  command = "setlocal wrap",
})

autocmd("FileType", {
  pattern = "gitcommit",
  group = Git,
  command = "setlocal spell",
})

--[[ Markdown ]]
local Markdown = augroup("MarkdownGroup", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  group = Markdown,
  command = "setlocal textwidth=80",
})

autocmd("FileType", {
  pattern = "*.md",
  group = Markdown,
  command = "setlocal spell",
})

--[[ Auto resize ]]
local AutoResize = augroup("AutoResizeGroup", { clear = true })
autocmd("VimResized", {
  pattern = "*",
  group = Markdown,
  command = "tabdo wincmd =",
})

--[[ Highlight on yank ]]
local HighlightGroup = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = HighlightGroup,
  pattern = "*",
})

--[[ Clear registers ]]
vim.cmd [[
  command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
]]
