local ok, neotree = pcall(require, "neo-tree")
if not ok then
  return
end

local icons = require("utils").icons
local renderer = require "neo-tree.ui.renderer"

local function expand_all(state, root)
  local toggle_directory = function(_, node)
    node:expand()
  end

  local expand_node
  expand_node = function(node)
    local id = node:get_id()
    if node.type == "directory" and not node:is_expanded() then
      toggle_directory(state, node)
      node = state.tree:get_node(id)
    end

    local children = state.tree:get_nodes(id)
    if children then
      for _, child in ipairs(children) do
        if child.type == "directory" then
          expand_node(child)
        end
      end
    end
  end

  expand_node(root)
  renderer.redraw(state)
end

local function open_dir(state, dir_node, callback)
  local fs = require "neo-tree.sources.filesystem"
  fs.toggle_directory(state, dir_node, nil, true, true, callback)
end

local function recursive_open(state, node, max_depth)
  open_dir(state, node, function()
    expand_all(state, node)
  end)
end

local function expand_directory(state, open_all)
  local node = state.tree:get_node()

  if open_all then
    recursive_open(state, node)
  else
    recursive_open(state, node, node:get_depth() + vim.v.count1)
  end

  renderer.redraw(state)
end

neotree.setup {
  auto_clean_after_session_restore = true,
  close_if_last_window = true,
  enable_diagnostics = false,
  sources = { "filesystem", "buffers", "git_status" },
  source_selector = {
    winbar = true,
    content_layout = "center",
    sources = {
      { source = "filesystem", display_name = icons.ui.Folder .. " File" },
      { source = "buffers",    display_name = icons.ui.File .. " Bufs" },
      { source = "git_status", display_name = icons.git.GitIcon .. " Git" },
    },
  },
  default_component_configs = {
    indent = {
      padding = 0,
      highlight = "NeoTreeIndentMarket",
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = icons.ui.TriangleRight,
      expander_expanded = icons.ui.TriangleDown,
      expander_highlight = "NeoTreeIndentMarket",
    },
    icon = {
      folder_closed = icons.ui.Folder,
      folder_open = icons.ui.FolderOpen,
      folder_empty = icons.ui.EmptyFolder,
      folder_empty_open = icons.ui.EmptyFolderOpen,
      default = icons.ui.File,
    },
    modified = { symbol = icons.ui.Circle },
    git_status = {
      symbols = {
        added = icons.ui.Circle,
        modified = icons.git.LineModified,
        deleted = icons.git.FileDeleted,
        renamed = icons.git.FileRenamed,
        untracked = icons.git.FileUntracked,
        ignored = icons.git.FileIgnored,
        unstaged = icons.git.FileUnstaged,
        staged = icons.git.FileStaged,
        conflict = icons.git.Conflict,
      },
    },
  },
  window = {
    width = 40,
    mappings = {
      -- Navigation with HJKL
      ["h"] = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" and node:is_expanded() then
          require("neo-tree.sources.filesystem").toggle_directory(state, node)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      ["l"] = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" then
          if not node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          elseif node:has_children() then
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        end
      end,
      ["w"] = false,
      ["E"] = expand_directory,
    },
    fuzzy_finder_mappings = {
      ["<C-j>"] = "move_cursor_down",
      ["<C-k>"] = "move_cursor_up",
    }
  },
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_hidden = false,
    },
    follow_current_file = { enabled = true },
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
  },
  event_hanlders = {
    {
      event = "neo_tree_buffer_enter",
    },
    handler = function(_)
      vim.opt_local.signcolumn = "auto"
    end,
  },
}
