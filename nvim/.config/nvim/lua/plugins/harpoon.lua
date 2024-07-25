local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local ok, harpoon = pcall(require, "harpoon")
  if not ok then
    return
  end

  harpoon:setup()
end

return M
