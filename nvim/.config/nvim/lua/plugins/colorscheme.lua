local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  -- commit = "2e3e5ebcdc24ef0d5b14a0a999dbbe7936512c46",
  lazy = false,
  priority = 1000,
}

function M.config()
  vim.cmd.colorscheme "catppuccin"
end

return M
