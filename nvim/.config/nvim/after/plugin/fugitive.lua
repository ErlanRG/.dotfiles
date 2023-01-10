local ok, fugitive = pcall(require, "vim_fugitive")
if not ok then
  return
end

fugitive.setup {}
