local M = {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
}

function M.config()
  local status_ok, nvim_tree = pcall(require, "nvim-tree")
  if not status_ok then
    return
  end

  local api = require "nvim-tree.api"
  local icons = require "utils.icons"

  local function on_attach(bufnr)
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local mappings = {
      ["<C-]>"] = { api.tree.change_root_to_node, "CD" },
      ["<C-e>"] = { api.node.open.replace_tree_buffer, "Open: In Place" },
      ["<C-k>"] = { api.node.show_info_popup, "Info" },
      ["<C-r>"] = { api.fs.rename_sub, "Rename: Omit Filename" },
      ["<C-t>"] = { api.node.open.tab, "Open: New Tab" },
      ["<C-v>"] = { api.node.open.vertical, "Open: Vertical Split" },
      ["<C-x>"] = { api.node.open.horizontal, "Open: Horizontal Split" },
      ["<BS>"] = { api.node.navigate.parent_close, "Close Directory" },
      -- ["<CR>"] = { api.node.open.edit, "Open" },
      ["<Tab>"] = { api.node.open.preview, "Open Preview" },
      [">"] = { api.node.navigate.sibling.next, "Next Sibling" },
      ["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },
      ["."] = { api.node.run.cmd, "Run Command" },
      ["-"] = { api.tree.change_root_to_parent, "Up" },
      ["a"] = { api.fs.create, "Create" },
      ["bmv"] = { api.marks.bulk.move, "Move Bookmarked" },
      ["B"] = { api.tree.toggle_no_buffer_filter, "Toggle No Buffer" },
      ["c"] = { api.fs.copy.node, "Copy" },
      -- ["C"] = { api.tree.toggle_git_clean_filter, "Toggle Git Clean" },
      ["[c"] = { api.node.navigate.git.prev, "Prev Git" },
      ["]c"] = { api.node.navigate.git.next, "Next Git" },
      ["d"] = { api.fs.remove, "Delete" },
      ["D"] = { api.fs.trash, "Trash" },
      ["E"] = { api.tree.expand_all, "Expand All" },
      ["e"] = { api.fs.rename_basename, "Rename: Basename" },
      ["]e"] = { api.node.navigate.diagnostics.next, "Next Diagnostic" },
      ["[e"] = { api.node.navigate.diagnostics.prev, "Prev Diagnostic" },
      ["F"] = { api.live_filter.clear, "Clean Filter" },
      ["f"] = { api.live_filter.start, "Filter" },
      ["g?"] = { api.tree.toggle_help, "Help" },
      ["gy"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },
      ["H"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
      ["I"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
      ["J"] = { api.node.navigate.sibling.last, "Last Sibling" },
      ["K"] = { api.node.navigate.sibling.first, "First Sibling" },
      ["m"] = { api.marks.toggle, "Toggle Bookmark" },
      -- ["o"] = { api.node.open.edit, "Open" },
      ["O"] = { api.node.open.no_window_picker, "Open: No Window Picker" },
      ["p"] = { api.fs.paste, "Paste" },
      ["P"] = { api.node.navigate.parent, "Parent Directory" },
      ["q"] = { api.tree.close, "Close" },
      ["r"] = { api.fs.rename, "Rename" },
      ["R"] = { api.tree.reload, "Refresh" },
      ["s"] = { api.node.run.system, "Run System" },
      ["S"] = { api.tree.search_node, "Search" },
      ["U"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },
      ["W"] = { api.tree.collapse_all, "Collapse" },
      ["x"] = { api.fs.cut, "Cut" },
      ["y"] = { api.fs.copy.filename, "Copy Name" },
      ["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
      ["<2-LeftMouse>"] = { api.node.open.edit, "Open" },
      ["<2-RightMouse>"] = { api.tree.change_root_to_node, "CD" },

      -- Mappings migrated from view.mappings.list
      ["l"] = { api.node.open.edit, "Open" },
      ["<CR>"] = { api.node.open.edit, "Open" },
      ["o"] = { api.node.open.edit, "Open" },
      ["h"] = { api.node.navigate.parent_close, "Close Directory" },
      ["v"] = { api.node.open.vertical, "Open: Vertical Split" },
      ["C"] = { api.tree.change_root_to_node, "CD" },
    }

    for keys, mapping in pairs(mappings) do
      vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
    end
  end

  -- Automatically open file upon creation
  --- @see https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#automatically-open-file-upon-creation
  api.events.subscribe(api.events.Event.FileCreated, function(file)
    vim.cmd("edit" .. file.fname)
  end)

  nvim_tree.setup {
    on_attach = on_attach,
    auto_reload_on_write = false,
    disable_netrw = false,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = false,
    reload_on_bufenter = false,
    view = {
      adaptive_size = false,
      centralize_selection = false,
      width = 40,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      highlight_git = true,
      full_name = false,
      highlight_opened_files = "all",
      root_folder_label = ":t",
      indent_width = 2,
      indent_markers = {
        enable = false,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = icons.ui.LineMiddle,
          item = icons.ui.LineMiddle,
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "after",
        padding = " ",
        symlink_arrow = " " .. icons.ui.SymlinkArrow .. " ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = icons.ui.Text,
          symlink = icons.ui.FileSymlink,
          bookmark = icons.ui.BookMark,
          folder = {
            arrow_closed = icons.ui.Triangle,
            arrow_open = icons.ui.TriangleShortArrowDown,
            default = icons.ui.Folder,
            open = icons.ui.FolderOpen,
            empty = icons.ui.EmptyFolder,
            empty_open = icons.ui.EmptyFolderOpen,
            symlink = icons.ui.FolderSymlink,
            symlink_open = icons.ui.FolderOpen,
          },
          git = {
            unstaged = icons.git.FileUnstaged,
            staged = icons.git.FileStaged,
            unmerged = icons.git.FileUnmerged,
            renamed = icons.git.FileRenamed,
            untracked = icons.git.FileUntracked,
            deleted = icons.git.FileDeleted,
            ignored = icons.git.FileIgnored,
          },
        },
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "LICENSE" },
      symlink_destination = true,
    },
    hijack_directories = {
      enable = false,
      auto_open = true,
    },
    update_focused_file = {
      enable = false,
      debounce_delay = 15,
      update_root = true,
      ignore_list = {},
    },
    diagnostics = {
      enable = true,
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = icons.diagnostics.BoldHint,
        info = icons.diagnostics.BoldInformation,
        warning = icons.diagnostics.BoldWarning,
        error = icons.diagnostics.BoldError,
      },
    },
    filters = {
      dotfiles = false,
      git_clean = false,
      no_buffer = false,
      custom = { "node_modules", "\\.cache" },
      exclude = {},
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
      ignore_dirs = {},
    },
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      show_on_open_dirs = true,
      timeout = 200,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
        exclude = {},
      },
      file_popup = {
        open_win_config = {
          col = 1,
          row = 1,
          relative = "cursor",
          border = "shadow",
          style = "minimal",
        },
      },
      open_file = {
        quit_on_open = false,
        resize_window = false,
        window_picker = {
          enable = true,
          picker = "default",
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    trash = {
      cmd = "trash",
      require_confirm = true,
    },
    live_filter = {
      prefix = icons.ui.Search .. " ",
      always_show_folders = false,
    },
    tab = {
      sync = {
        open = false,
        close = false,
        ignore = {},
      },
    },
    notify = {
      threshold = vim.log.levels.INFO,
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
    system_open = {
      cmd = nil,
      args = {},
    },
  }
end

return M
