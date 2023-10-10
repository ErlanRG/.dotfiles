vim.g.barbar_auto_setup = false

local status_ok, barbar = pcall(require, "barbar")
if not status_ok then
  return
end

local icons = require("utils").icons

barbar.setup {
  animation = false,
  auto_hide = false,
  clickable = true,
  icons = {
    -- Configure the base icons on the bufferline.
    buffer_index = false,
    buffer_number = false,
    button = icons.ui.Close,
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.diagnostics.BoldError .. " " },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = icons.diagnostics.BoldWarning .. " " },
      [vim.diagnostic.severity.INFO] = { enabled = true, icon = icons.diagnostics.BoldInformation .. " " },
      [vim.diagnostic.severity.HINT] = { enabled = true, icon = icons.diagnostics.BoldHint .. " " },
    },
  },
  insert_at_end = true,
  sidebar_filetypes = {
    NvimTree = { text = "NvimTree" },
    ["neo-tree"] = {
      event = "BufWipeout",
    },
  },
  no_name_title = "New Buffer",
}
