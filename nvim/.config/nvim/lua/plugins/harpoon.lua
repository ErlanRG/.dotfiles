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

  -- REQUIRED
  harpoon:setup()
  -- REQUIRED

  vim.keymap.set("n", "<leader>a", function()
    harpoon:list():append()
  end)
  vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end)

  vim.keymap.set("n", "<C-g>", function()
    harpoon:list():select(1)
  end)
  vim.keymap.set("n", "<C-t>", function()
    harpoon:list():select(2)
  end)
  vim.keymap.set("n", "<C-n>", function()
    harpoon:list():select(3)
  end)
  vim.keymap.set("n", "<C-s>", function()
    harpoon:list():select(4)
  end)
end

return M
