local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
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
    disable = function(lang, buf)
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = true,
  },
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  playground = {
    enable = true,
  },
}
