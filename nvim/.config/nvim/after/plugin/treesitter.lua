local configs = require "nvim-treesitter.configs"
configs.setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "help",
    "lua",
    "python",
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
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  playground = {
    enable = true,
  }
}
