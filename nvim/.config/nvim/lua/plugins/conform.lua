local M = {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local status_ok, conform = pcall(require, "conform")
  if not status_ok then
    return
  end

  conform.setup {
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang_format" },
      cpp = { "clang_format" },
    },
  }
end

return M
