local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/neodev.nvim",
      commit = "b094a663ccb71733543d8254b988e6bebdbdaca4",
    },
    {
      "RRethy/vim-illuminate",
      event = "VeryLazy",
    },
  },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  local mappings = {
    n = {
      ["gD"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
      ["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
      ["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
      ["gI"] = "<cmd>lua vim.lsp.buf.implementation()<CR>",
      ["gr"] = "<cmd>lua vim.lsp.buf.references()<CR>",
      ["gl"] = "<cmd>lua vim.diagnostic.open_float()<CR>",
      ["<leader>li"] = "<cmd>LspInfo<CR>",
      -- ["<leader>la"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
      ["<leader>la"] = "<cmd>Lspsaga code_action<CR>",
      ["<leader>lj"] = "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
      ["<leader>lk"] = "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>",
      -- ["<leader>lr"] = "<cmd>lua vim.lsp.buf.rename()<CR>",
      ["<leader>lr"] = "<cmd>Lspsaga rename mode=n<CR>",
      ["<leader>ls"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
      ["<leader>lq"] = "<cmd>lua vim.diagnostic.setloclist()<CR>",
    },
  }

  for mode, keys in pairs(mappings) do
    for key, mapping in pairs(keys) do
      keymap(bufnr, mode, key, mapping, opts)
    end
  end
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  local illuminate = require "illuminate"
  illuminate.on_attach(client)
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

function M.config()
  local lspconfig = require "lspconfig"
  local icons = require "utils.icons"

  local servers = {
    "bashls",
    "clangd",
    "emmet_ls",
    "gopls",
    "lua_ls",
    "pyright",
    "tsserver",
  }

  local default_diagnostic_config = {
    virtual_text = {
      prefix = icons.ui.Circle,
    },
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
      },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local require_ok, settings = pcall(require, "plugins.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if server == "lua_ls" then
      require("neodev").setup {}
    end

    lspconfig[server].setup(opts)
  end
end

return M
