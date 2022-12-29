vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  return
end

catppuccin.setup{}

local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
