local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  sources = {
    -- Formatting
    formatting.beautysh.with {
      extra_args = { "-i 2" }, -- indent with 2 spaces.
    },
    formatting.prettier,
    formatting.stylua,

    -- Diagnostics
  },
}
