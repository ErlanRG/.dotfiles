local copilot_ok, copilot = pcall(require, "copilot")
if not copilot_ok then
  return
end

local copilotcmp_ok, copilot_cmp = pcall(require, "copilot_cmp")
if not copilotcmp_ok then
  return
end

-- Load copilot cmp
copilot_cmp.setup {}

copilot.setup {
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      -- open = "<M-CR>",
    },
    layout = {
      position = "right", -- | top | left | right
      ratio = 0.4,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<M-CR>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = true,
    gitrebase = true,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node", -- Node.js version must be > 16.x
  server_opts_overrides = {},
}
