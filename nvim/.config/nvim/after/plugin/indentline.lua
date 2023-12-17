local ibl_ok, ibl = pcall(require, "ibl")
if not ibl_ok then
  return
end

local hooks_ok, hooks = pcall(require, "ibl.hooks")
if not hooks_ok then
  return
end

local highlight = {
  "LineColor",
}

-- Set indenline color.
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "LineColor", { fg = "#cdd6f4" })
end)

local icons = require("utils.icons")

ibl.setup {
  enabled = true,
  indent = {
    char = icons.ui.LineLeft,
    smart_indent_cap = true,
  },
  whitespace = {
    remove_blankline_trail = true,
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
    injected_languages = false,
    highlight = highlight,
    include = {
      node_type = {
        ["*"] = {
          "^argument",
          "^expression",
          "^for",
          "^if",
          "^import",
          "^type",
          "arguments",
          "block",
          "bracket",
          "declaration",
          "field",
          "func_literal",
          "function",
          "import_spec_list",
          "list",
          "return_statement",
          "short_var_declaration",
          "statement",
          "switch_body",
          "table_constructor",
          "try",
        },
      },
    },
  },
  exclude = {
    buftypes = {
      "terminal",
      "nofile",
    },
    filetypes = {
      "help",
      "startify",
      "dashboard",
      "lazy",
      "neogitstatus",
      "NvimTree",
      "Trouble",
    },
  },
}
