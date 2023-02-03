local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"

telescope.setup {
  defaults = {
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    buffer_previewer_maker = previewers.buffer_previewer_maker,
    color_devicons = true,
    entry_prefix = "  ",
    file_ignore_patterns = { "node_modules" },
    file_previewer = previewers.vim_buffer_cat.new,
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    initial_mode = "insert",
    layout_strategy = "horizontal",
    path_display = { "truncate" },
    prompt_prefix = "   ",
    qflist_previewer = previewers.vim_buffer_qflist.new,
    selection_caret = "  ",
    selection_strategy = "reset",
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    sorting_strategy = "ascending",
    winblend = 0,
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      n = { ["q"] = actions.close },
    },
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  },

  extensions_list = { "themes", "terms" },
}
