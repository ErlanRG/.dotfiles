--[[ Onedark ]]
local onedark_ok, onedark = pcall(require, "onedark")
if not onedark_ok then
  return
end

onedark.setup {
  style = "darker",
  transparent = "false",
  term_colors = "true",
}

--[[ Catppuccin ]]
local cat_ok, catppuccin = pcall(require, "catppuccin")
if not cat_ok then
  return
end

catppuccin.setup {
  catppuccin_flavour = "mocha",
  custom_highlights = function(C)
    return {
      NeoTreeWinSeparator = { fg = C.blue },
    }
  end,
  integrations = {
    cmp = true,
    dashboard = true,
    neotree = true,
    nvimtree = true,
    telescope = true,
  },
}

--[[ Rosepine ]]
local rose_ok, rosepine = pcall(require, "rose-pine")
if not rose_ok then
  return
end

rosepine.setup {
  disable_background = true,
}

--[[ Setup ]]
function SetColors(color)
  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetColors()