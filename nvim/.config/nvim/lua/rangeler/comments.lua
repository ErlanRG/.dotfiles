local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  ---Add a space b/w comment and the line
  padding = true,
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
}
