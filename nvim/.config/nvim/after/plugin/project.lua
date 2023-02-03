local ok, project = pcall(require, "project_nvim")
if not ok then
  return
end

project.setup {
  datapath = vim.fn.stdpath "data",
  detection_methods = { "pattern" },
  exclude_dirs = {},
  ignore_lsp = {},
  manual_mode = false,
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
  scope_chdir = "global",
  show_hidden = false,
  silent_chdir = true,
}

local tele_ok, telescope = pcall(require, "telescope")
if not tele_ok then
  return
end

telescope.load_extension "projects"
