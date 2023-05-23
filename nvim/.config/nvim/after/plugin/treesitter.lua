local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
if not configs_ok then
  return
end

configs.setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "lua",
    "rust",
    "vim",
  },
  sync_install = false,
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  autopairs = {
    enable = true,
  },
  -- @@@
  -- TODO: find out why rainbow is braking the buffer kill function.
  -- By now, it should remain disabled.
  -- rainbow = {
  --   enable = false,
  --   query = "rainbow-parens",
  --   strategy = require("ts-rainbow").strategy.global,
  -- },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  playground = {
    enable = true,
  },
}
