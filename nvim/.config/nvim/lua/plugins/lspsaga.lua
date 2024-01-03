local M = {
  "nvimdev/lspsaga.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local status_ok, lspsaga = pcall(require, "lspsaga")
  if not status_ok then
    return
  end

  local icons = require "utils.icons"

  lspsaga.setup {
    symbol_in_winbar = {
      enable = true,
      show_file = true,
      folder_level = 0,
    },
    code_action = {
      num_shortcut = true,
      extend_gitsigns = true,
    },
    lightbulb = {
      enable = false,
      sign = false,
    },
    rename = {
      in_select = true,
    },
    ui = {
      code_action = " " .. icons.diagnostics.BoldHint .. " ",
    },
  }
end

return M
