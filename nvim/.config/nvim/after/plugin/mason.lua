local to_install = {
  "bashls",
  "sumneko_lua",
}

local settings = {
  ui = {
    check_outdated_packages_on_open = true,
    border = "none",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  },
}

local mason_status, mason = pcall(require, "mason")
local mason_lsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")

if not mason_status then
  return
end

if not mason_lsp_status then
  return
end

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = to_install,
  automatic_installation = true,
}
