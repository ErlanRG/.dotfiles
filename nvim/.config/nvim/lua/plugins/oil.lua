local M = {
  "stevearc/oil.nvim",
  event = "VeryLazy",
}

function M.config()
  local status_ok, oil = pcall(require, "oil")
  if not status_ok then
    return
  end

  local settings = {
    default_file_explorer = true,
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["l"] = "actions.select",
      ["h"] = "actions.parent",
      ["q"] = "actions.close",
    }
  }

  oil.setup(settings)
end

return M
