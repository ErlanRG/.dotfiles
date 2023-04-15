vim.g.barbar_auto_setup = false

local status_ok, barbar = pcall(require, "barbar")
if not status_ok then
  return
end

barbar.setup {
  animation = true,
  auto_hide = true,
  clickable = true,
  icons = {
    -- Configure the base icons on the bufferline.
    buffer_index = false,
    buffer_number = false,
    button = "",
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = "" },
      [vim.diagnostic.severity.INFO] = { enabled = true, icon = "" },
      [vim.diagnostic.severity.HINT] = { enabled = true, icon = "" },
    },
  },
  insert_at_end = true,
  sidebar_filetypes = {
    NvimTree = { text = "NvimTree" },
  },
  no_name_title = "New Buffer",
}
