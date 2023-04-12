local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
  return
end

vim.cmd [[
  imap <silent><script><expr> <C-A> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true
]]

copilot.setup {
  server_opts_overrides = {
    inlineSuggestCount = 3,
  },
}
