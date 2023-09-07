local M = {}

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = {
      prefix = "●",
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
      ["<leader>la"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
      ["<leader>lj"] = "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
      ["<leader>lk"] = "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>",
      ["<leader>lr"] = "<cmd>lua vim.lsp.buf.rename()<CR>",
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

--[[ nvim-navic ]]
local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then
  return
end

navic.setup {
  icons = {
    Array = "" .. " ",
    Boolean = "",
    Class = "" .. " ",
    Color = "" .. " ",
    Constant = "" .. " ",
    Constructor = "" .. " ",
    Enum = "" .. " ",
    EnumMember = "" .. " ",
    Event = "" .. " ",
    Field = "" .. " ",
    File = "" .. " ",
    Folder = "" .. " ",
    Function = "" .. " ",
    Interface = "" .. " ",
    Key = "" .. " ",
    Keyword = "" .. " ",
    Method = "" .. " ",
    Module = "" .. " ",
    Namespace = "" .. " ",
    Null = "ﳠ" .. " ",
    Number = "" .. " ",
    Object = "" .. " ",
    Operator = "" .. " ",
    Package = "" .. " ",
    Property = "" .. " ",
    Reference = "" .. " ",
    Snippet = "" .. " ",
    String = "" .. " ",
    Struct = "" .. " ",
    Text = "" .. " ",
    TypeParameter = "" .. " ",
    Unit = "" .. " ",
    Value = "" .. " ",
    Variable = "" .. " ",
  },
}

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

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
  -- "html",
  "jdtls",
  "lua_ls",
  "pyright",
  "rust_analyzer",
  -- "tailwindcss",
  -- "tsserver",
}

-- This only adds the extra configuration for the servers.
-- If it is not especified, then the server will use the defaults.
local languageModule = {
  clangd = "lang.clangd",
  rust_analyzer = "lang.rust",
  -- tailwindcss = "lang.tailwindcss",
  -- tsserver = "lang.tsserver",
}

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }

  server = vim.split(server, "@")[1]

  local moduleName = languageModule[server]
  if moduleName then
    opts = require(moduleName)
  end

  require("lspconfig")[server].setup(opts)
end

return M
