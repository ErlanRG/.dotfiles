local M = {}

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

local icons = require "utils.icons"

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
    { name = "DiagnosticSignWarn",  text = icons.diagnostics.BoldWarning },
    { name = "DiagnosticSignHint",  text = icons.diagnostics.BoldHint },
    { name = "DiagnosticSignInfo",  text = icons.diagnostics.BoldInformation },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = {
      prefix = icons.ui.Circle,
    },
    signs = {
      active = signs,
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

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

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

  local ill_ok, illuminate = pcall(require, "illuminate")
  if not ill_ok then
    return
  end

  illuminate.on_attach(client)
end

-- Server configuration
local servers = {
  "bashls",
  "clangd",
  "emmet_ls",
  "lua_ls",
  "pyright",
  "tsserver",
}

local languageModule = {
  clangd = "lang.clangd",
}

--- Adds the extra configuration for the servers.
-- If not especified, then the server will use the defaults.
M.moduleName = function(server, opts)
  local moduleName = languageModule[server]
  if moduleName then
    local moduleConfig = require(moduleName)
    if type(moduleConfig) == "table" then
      for key, value in pairs(moduleConfig) do
        opts[key] = value
      end
    end
  end
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }

  server = vim.split(server, "@")[1]

  M.moduleName(server, opts)

  require("lspconfig")[server].setup(opts)
end

return M
