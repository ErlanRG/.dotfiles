local ok, neoai = pcall(require, "neoai")
if not ok then
  return
end

neoai.setup {}
