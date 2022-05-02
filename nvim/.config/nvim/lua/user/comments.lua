local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

-- Check if this needs an actual setup or if it should be left with the default one

comment.setup {
}
