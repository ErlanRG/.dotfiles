local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  dependencies = { "echasnovski/mini.icons" },
}

function M.config()
  local mappings = {
    { "<leader>;", "<cmd>Alpha<CR>", desc = "Dashboard", nowait = true, remap = false },
    { "<leader>]", "<cmd>Copilot panel<CR>", desc = "Copilot panel", nowait = true, remap = false },
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer", nowait = true, remap = false },
    { "<leader>p", '"_dP', desc = "Special Paste", nowait = true, remap = false },
    { "<leader>w", vim.cmd.update, desc = "Save buffer", nowait = true, remap = false },

    -- Git diff
    { "<leader>D", group = "Git Diff", nowait = true, remap = false },
    { "<leader>Dc", "<cmd>DiffviewClose<cr>", desc = "Close", nowait = true, remap = false },
    { "<leader>Dr", "<cmd>DiffviewRefresh<cr>", desc = "Refresh", nowait = true, remap = false },
    { "<leader>Dv", "<cmd>DiffviewOpen<cr>", desc = "Open", nowait = true, remap = false },

    -- Plugins
    { "<leader>P", group = "Plugins", nowait = true, remap = false },
    { "<leader>PS", "<cmd>Lazy clear<cr>", desc = "Status", nowait = true, remap = false },
    { "<leader>Pc", "<cmd>Lazy clean<cr>", desc = "Clean", nowait = true, remap = false },
    { "<leader>Pd", "<cmd>Lazy debug<cr>", desc = "Debug", nowait = true, remap = false },
    { "<leader>Pi", "<cmd>Lazy install<cr>", desc = "Install", nowait = true, remap = false },
    { "<leader>Pl", "<cmd>Lazy log<cr>", desc = "Log", nowait = true, remap = false },
    { "<leader>Pp", "<cmd>Lazy profile<cr>", desc = "Profile", nowait = true, remap = false },
    { "<leader>Ps", "<cmd>Lazy sync<cr>", desc = "Sync", nowait = true, remap = false },
    { "<leader>Pu", "<cmd>Lazy update<cr>", desc = "Update", nowait = true, remap = false },

    -- Trouble
    { "<leader>T", group = "Trouble", nowait = true, remap = false },
    { "<leader>TR", "<cmd>Trouble lsp_references<CR>", desc = "LSP References", nowait = true, remap = false },
    { "<leader>Td", "<cmd>Trouble lsp_definitions<CR>", desc = "LSP Definitions", nowait = true, remap = false },
    { "<leader>Tr", "<cmd>Trouble document_diagnostics<CR>", desc = "Open diagnostics", nowait = true, remap = false },
    {
      "<leader>c",
      "<cmd>lua require 'utils.functions'.buf_kill()<CR>",
      desc = "Close buffer",
      nowait = true,
      remap = false,
    },

    -- Debug
    { "<leader>d", group = "Debug", nowait = true, remap = false },
    { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor", nowait = true, remap = false },
    {
      "<leader>dU",
      "<cmd>lua require'dapui'.toggle({reset = true})<cr>",
      desc = "Toggle UI",
      nowait = true,
      remap = false,
    },
    { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back", nowait = true, remap = false },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", nowait = true, remap = false },
    { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect", nowait = true, remap = false },
    { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session", nowait = true, remap = false },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = true, remap = false },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = true, remap = false },
    { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause", nowait = true, remap = false },
    { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", nowait = true, remap = false },
    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", nowait = true, remap = false },
    { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start", nowait = true, remap = false },
    {
      "<leader>dt",
      "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
      desc = "Toggle Breakpoint",
      nowait = true,
      remap = false,
    },
    { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = true, remap = false },

    -- Telescope
    { "<leader>f", group = "Find", nowait = true, remap = false },
    { "<leader>fK", "<cmd>Telescope keymaps<CR>", desc = "Keymaps", nowait = true, remap = false },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers", nowait = true, remap = false },
    { "<leader>fc", "<cmd>Telescope colorscheme<CR>", desc = "Colorschemes", nowait = true, remap = false },
    {
      "<leader>ff",
      "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
      desc = "Find files",
      nowait = true,
      remap = false,
    },
    { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Find git files", nowait = true, remap = false },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find help", nowait = true, remap = false },
    {
      "<leader>fk",
      "<cmd>lua require('plugins.telescope').grep_string()<CR>",
      desc = "Grep String",
      nowait = true,
      remap = false,
    },

    -- LSP
    { "<leader>l", group = "LSP", nowait = true, remap = false },
    {
      "<leader>lf",
      function()
        require("utils.functions").lsp_formatting()
      end,
      desc = "Format",
      nowait = true,
      remap = false,
    },
    { "<leader>lI", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
    { "<leader>lR", "<cmd>LspRestart<CR>", desc = "Restart server", nowait = true, remap = false },

    { "<leader>t", group = "Terminal", nowait = true, remap = false },
    { "<leader>tg", "<cmd>lua _lazygit_toggle()<cr>", desc = "Open Lazygit", nowait = true, remap = false },
    { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Open Terminal", nowait = true, remap = false },

    { "<leader>s", group = "Split buffers", nowait = true, remap = false },
    { "<leader>sv", vim.cmd.vnew, desc = "Vertical split", nowait = true, remap = false },
    { "<leader>sh", vim.cmd.new, desc = "Horizontal split", nowait = true, remap = false },
  }

  local config = {
    preset = "modern",
    notify = true,
    delay = 500,
    filter = function(map)
      return map.desc and map.desc ~= ""
    end,
    spec = mappings,
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    win = {
      no_overlap = true,
      -- width = 1,
      -- height = { min = 4, max = 25 },
      -- col = 0,
      -- row = math.huge,
      -- border = "none",
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      title = "Keybindings",
      title_pos = "center",
      zindex = 1000,
      -- Additional vim.wo and vim.bo options
      bo = {},
      wo = {
        winblend = 40,
      },
    },
  }

  local ok, wk = pcall(require, "which-key")
  if not ok then
    return
  end

  wk.setup(config)
end

return M
