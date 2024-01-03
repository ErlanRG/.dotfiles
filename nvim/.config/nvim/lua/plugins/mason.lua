local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
}

M.servers = {
  "bashls",
  "clangd",
  "emmet_ls",
  "lua_ls",
  "pyright",
  "tsserver",
}

function M.config()
  local mason_status, mason = pcall(require, "mason")
  local mason_lsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")

  if not mason_status then
    return
  end

  if not mason_lsp_status then
    return
  end
  local icons = require "utils.icons"

  local settings = {
    ui = {
      check_outdated_packages_on_open = true,
      border = "none",
      icons = {
        package_pending = icons.ui.Target,
        package_installed = icons.ui.BoldCircleCheck,
        package_uninstalled = icons.misc.Skull,
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
  }

  mason.setup(settings)
  mason_lspconfig.setup {
    ensure_installed = M.servers,
    automatic_installation = true,
  }
end

return M
