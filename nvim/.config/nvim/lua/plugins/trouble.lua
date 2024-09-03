local M = {
  "folke/trouble.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local ok, trouble = pcall(require, "trouble")
  if not ok then
    return
  end

  local icons = require "utils.icons"

  trouble.setup {
    auto_close = true,
    focus = true,
    icons = {
      indent = {
        fold_open = icons.ui.TriangleShortArrowDown,
        fold_closed = icons.ui.Triangle,
      },
    },
  }
end

return M
