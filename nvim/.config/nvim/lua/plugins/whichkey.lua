local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local mappings = {
    [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
    ["]"] = { "<cmd>Copilot panel<CR>", "Copilot panel" },
    ["c"] = { "<cmd>lua require 'utils.functions'.buf_kill()<CR>", "Close buffer" },
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    ["p"] = { '"_dP', "Special Paste" },
    ["w"] = { vim.cmd.update, "Save buffer" },
    D = {
      name = "Git Diff",
      v = { "<cmd>DiffviewOpen<cr>", "Open" },
      c = { "<cmd>DiffviewClose<cr>", "Close" },
      r = { "<cmd>DiffviewRefresh<cr>", "Refresh" },
    },
    d = {
      name = "Debug",
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
    },
    f = {
      name = "Find",
      K = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
      b = { "<cmd>Telescope buffers<CR>", "Buffers" },
      c = { "<cmd>Telescope colorscheme<CR>", "Colorschemes" },
      f = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", "Find files" },
      g = { "<cmd>Telescope git_files<CR>", "Find git files" },
      h = { "<cmd>Telescope help_tags<CR>", "Find help" },
      k = { "<cmd>lua require('plugins.telescope').grep_string()<CR>", "Grep String" },
    },
    l = {
      name = "LSP",
      f = { vim.lsp.buf.format, "Format" },
      I = { "<cmd>LspInfo<cr>", "Info" },
      R = { "<cmd>LspRestart<CR>", "Restart server" },
      F = { "<cmd>lua require('utils.functions').lsp_formatting()<CR>", "Format" },
    },
    P = {
      name = "Plugins",
      S = { "<cmd>Lazy clear<cr>", "Status" },
      c = { "<cmd>Lazy clean<cr>", "Clean" },
      d = { "<cmd>Lazy debug<cr>", "Debug" },
      i = { "<cmd>Lazy install<cr>", "Install" },
      l = { "<cmd>Lazy log<cr>", "Log" },
      p = { "<cmd>Lazy profile<cr>", "Profile" },
      s = { "<cmd>Lazy sync<cr>", "Sync" },
      u = { "<cmd>Lazy update<cr>", "Update" },
    },
    t = {
      name = "Terminal",
      t = { "<cmd>ToggleTerm<CR>", "Open Terminal" },
      g = { "<cmd>lua _lazygit_toggle()<cr>", "Open Lazygit" },
    },
    T = {
      name = "Trouble",
      R = { "<cmd>Trouble lsp_references<CR>", "LSP References" },
      d = { "<cmd>Trouble lsp_definitions<CR>", "LSP Definitions" },
      r = { "<cmd>Trouble document_diagnostics<CR>", "Open diagnostics" },
    },
  }

  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  }

  local ok, wk = pcall(require, "which-key")
  if not ok then
    return
  end
  wk.setup {
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    popup_mappings = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
    window = {
      border = "rounded",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 2, 2, 2, 2 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "center",
    },
    ignore_missing = true,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = true,
    show_keys = true,
    triggers = "auto",
    triggers_blacklist = {
      i = { "j", "k" },
      v = { "j", "k" },
    },
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  wk.register(mappings, opts)
end

return M
