local M = {
  "ggandor/leap.nvim",
  event = "VeryLazy",
}

function M.config()
  local status_ok, leap = pcall(require, "leap")
  if not status_ok then
    return
  end

  leap.add_default_mappings()

  leap.setup {
    case_sensitive = false,
  }
end

return M
