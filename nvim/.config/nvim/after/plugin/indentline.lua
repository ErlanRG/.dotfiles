local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

local opt = vim.opt

opt.list = true
opt.listchars:append "eol:↴"

indent_blankline.setup {
  show_end_of_line = true,
  show_current_context = true,
  show_current_context_start = true,
}
