return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = true,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  { "navarasu/onedark.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
}
