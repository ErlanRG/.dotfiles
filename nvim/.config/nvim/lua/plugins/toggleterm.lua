local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = true,
  cmd = { "ToggleTerm", "TermExec" },
}

function _lazygit_toggle()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new {
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "single",
    },
  }
  lazygit:toggle()
end

M.config = function()
  local ok, toggleterm = pcall(require, "toggleterm")
  if not ok then
    return
  end

  toggleterm.setup {
    direction = "float",
    float_opts = {
      border = "curved",
    },
  }
end

return M
