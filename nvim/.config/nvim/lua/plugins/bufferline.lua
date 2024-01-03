local M = {
  "akinsho/nvim-bufferline.lua",
}

function M.config()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  local mocha = require("catppuccin.palettes").get_palette "mocha"
  local icons = require "utils.icons"

  bufferline.setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get {
      styles = { "italic", "bold" },
      custom = {
        all = {
          background = { fg = mocha.text },
          fill = { bg = mocha.base },
          indicator_selected = { bg = mocha.base, fg = mocha.peach },
          indicator_visible = { bg = mocha.mantle, fg = mocha.mantle },
          separator = { bg = mocha.mantle, fg = mocha.crust },
          separator_visible = { bg = mocha.mantle, fg = mocha.mantle },
        },
      },
    },
    options = {
      numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      indicator = {
        style = "icon",
        icon = icons.ui.BoldLineLeft,
      },
      buffer_close_icon = icons.ui.Close,
      modified_icon = icons.ui.Circle,
      close_icon = icons.ui.Close,
      left_trunc_marker = icons.ui.ArrowCircleLeft,
      right_trunc_marker = icons.ui.ArrowCircleRight,
      max_name_length = 30,
      max_prefix_length = 30,
      tab_size = 21,
      diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
      diagnostics_update_in_insert = false,
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
      enforce_regular_tabs = true,
      always_show_bufferline = true,
    },
  }
end

return M
