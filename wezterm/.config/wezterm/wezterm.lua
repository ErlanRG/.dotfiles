-- https://github.com/thanhvule0310/dotfiles/blob/main/config/wezterm/wezterm.lua

local wezterm = require "wezterm"

local catppuccin_colors = {
  rosewater = "#F5E0DC",
  flamingo = "#F2CDCD",
  pink = "#F5C2E7",
  mauve = "#CBA6F7",
  red = "#F38BA8",
  maroon = "#EBA0AC",
  peach = "#FAB387",
  yellow = "#F9E2AF",
  green = "#A6E3A1",
  teal = "#94E2D5",
  sky = "#89DCEB",
  sapphire = "#74C7EC",
  blue = "#89B4FA",
  lavender = "#B4BEFE",

  text = "#CDD6F4",
  subtext1 = "#BAC2DE",
  subtext0 = "#A6ADC8",
  overlay2 = "#9399B2",
  overlay1 = "#7F849C",
  overlay0 = "#6C7086",
  surface2 = "#585B70",
  surface1 = "#45475A",
  surface0 = "#313244",

  base = "#1E1E2E",
  mantle = "#181825",
  crust = "#11111B",
}

local function get_process(tab)
  local wnf = wezterm.nerdfonts
  local PROCESS_ICONS = {
    ["docker"] = {
      { Foreground = { Color = catppuccin_colors.blue } },
      { Text = wnf.md_docker },
    },
    ["docker-compose"] = {
      { Foreground = { Color = catppuccin_colors.blue } },
      { Text = wnf.md_docker },
    },
    ["nvim"] = {
      { Foreground = { Color = catppuccin_colors.green } },
      { Text = wnf.custom_neovim },
    },
    ["vim"] = {
      { Foreground = { Color = catppuccin_colors.green } },
      { Text = wnf.custom_vim },
    },
    ["node"] = {
      { Foreground = { Color = catppuccin_colors.green } },
      { Text = wnf.md_hexagon },
    },
    ["zsh"] = {
      { Foreground = { Color = catppuccin_colors.peach } },
      { Text = wnf.dev_terminal },
    },
    ["bash"] = {
      { Foreground = { Color = catppuccin_colors.overlay1 } },
      { Text = wnf.cod_terminal_bash },
    },
    ["htop"] = {
      { Foreground = { Color = catppuccin_colors.yellow } },
      { Text = wnf.fa_area_chart },
    },
    ["go"] = {
      { Foreground = { Color = catppuccin_colors.sapphire } },
      { Text = wnf.seti_go },
    },
    ["git"] = {
      { Foreground = { Color = catppuccin_colors.red } },
      { Text = wnf.md_git },
    },
    ["lazygit"] = {
      { Foreground = { Color = catppuccin_colors.red } },
      { Text = wnf.md_git },
    },
    ["wget"] = {
      { Foreground = { Color = catppuccin_colors.yellow } },
      { Text = wnf.md_tray_arrow_down },
    },
    ["curl"] = {
      { Foreground = { Color = catppuccin_colors.yellow } },
      { Text = wnf.cod_arrow_swap },
    },
    ["gh"] = {
      { Foreground = { Color = catppuccin_colors.mauve } },
      { Text = wnf.dev_github_badge },
    },
    ["flatpak"] = {
      { Foreground = { Color = catppuccin_colors.blue } },
      { Text = wnf.md_package_variant },
    },
    ["yay"] = {
      { Foreground = { Color = catppuccin_colors.mauve } },
      { Text = wnf.md_arch },
    },
  }

  local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

  if PROCESS_ICONS[process_name] then
    return wezterm.format(PROCESS_ICONS[process_name])
  elseif process_name == "" then
    return wezterm.format {
      { Foreground = { Color = catppuccin_colors.red } },
      { Text = wezterm.nerdfonts.md_lock },
    }
  else
    return wezterm.format {
      { Foreground = { Color = catppuccin_colors.red } },
      { Text = string.format("[%s]", process_name) },
    }
  end
end

local function get_current_working_dir(tab)
  local cwd_uri = tab.active_pane.current_working_dir

  if cwd_uri then
    local cwd = ""
    if type(cwd_uri) == "userdata" then
      cwd = cwd_uri.file_path
    else
      cwd_uri = cwd_uri:sub(8)
      local slash = cwd_uri:find "/"
      if slash then
        cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
          return string.char(tonumber(hex, 16))
        end)
      end
    end

    if cwd == os.getenv "HOME" then
      return "~"
    end

    return string.format("%s", string.match(cwd, "[^/]+$"))
  end
end

wezterm.on("format-tab-title", function(tab)
  return wezterm.format {
    { Text = "  " },
    { Attribute = { Intensity = "Half" } },
    { Text = string.format("%s", tab.tab_index + 1) },
    "ResetAttributes",
    { Text = " " },
    { Text = get_process(tab) },
    { Text = "  " },
    { Text = get_current_working_dir(tab) },
    { Foreground = { Color = catppuccin_colors.base } },
    { Text = " ▕" },
  }
end)

return {
  audible_bell = "Disabled",
  color_scheme = "Catppuccin Mocha",
  disable_default_key_bindings = false,
  enable_scroll_bar = false,
  font_size = 12,
  font = wezterm.font("Iosevka Nerd Font", { weight = "DemiBold", stretch = "Normal", style = "Normal" }),
  hide_tab_bar_if_only_one_tab = true,
  show_new_tab_button_in_tab_bar = false,
  tab_bar_at_bottom = false,
  tab_max_width = 50,
  use_fancy_tab_bar = false,
  window_decorations = "RESIZE",
  inactive_pane_hsb = {
    brightness = 0.6,
    saturation = 1.0,
  },
  colors = {
    background = catppuccin_colors.base,
    split = catppuccin_colors.text,
    tab_bar = {
      active_tab = {
        bg_color = catppuccin_colors.base,
        fg_color = catppuccin_colors.text,
      },
      inactive_tab = {
        bg_color = catppuccin_colors.crust,
        fg_color = catppuccin_colors.surface1,
      },
      background = catppuccin_colors.base,
    },
  },
  window_frame = {
    font = wezterm.font { family = "Iosevka Nerd Font" },
    font_size = 10,
  },
  window_padding = {
    bottom = 2,
    left = 2,
    right = 2,
  },
  leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    -- Open/close tabs
    { mods = "LEADER", key = "w", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    { mods = "LEADER", key = "Q", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
    { mods = "LEADER", key = "q", action = wezterm.action { CloseCurrentPane = { confirm = true } } },
    -- Window movement
    { mods = "ALT", key = "h", action = wezterm.action { ActivateTabRelative = -1 } },
    { mods = "ALT", key = "l", action = wezterm.action { ActivateTabRelative = 1 } },
    -- Splits
    { mods = "LEADER", key = "v", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { mods = "LEADER", key = "h", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },

    { mods = "LEADER|CTRL", key = "h", action = wezterm.action.ActivatePaneDirection "Left" },
    { mods = "LEADER|CTRL", key = "j", action = wezterm.action.ActivatePaneDirection "Down" },
    { mods = "LEADER|CTRL", key = "k", action = wezterm.action.ActivatePaneDirection "Up" },
    { mods = "LEADER|CTRL", key = "l", action = wezterm.action.ActivatePaneDirection "Right" },
    -- Resize
    { mods = "CTRL", key = "LeftArrow", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
    { mods = "CTRL", key = "DownArrow", action = wezterm.action.AdjustPaneSize { "Down", 5 } },
    { mods = "CTRL", key = "RightArrow", action = wezterm.action.AdjustPaneSize { "Right", 5 } },
    { mods = "CTRL", key = "UpArrow", action = wezterm.action.AdjustPaneSize { "Up", 5 } },
    -- Move to tab
    { mods = "ALT", key = "1", action = wezterm.action { ActivateTab = 0 } },
    { mods = "ALT", key = "2", action = wezterm.action { ActivateTab = 1 } },
    { mods = "ALT", key = "3", action = wezterm.action { ActivateTab = 2 } },
    { mods = "ALT", key = "4", action = wezterm.action { ActivateTab = 3 } },
    { mods = "ALT", key = "5", action = wezterm.action { ActivateTab = 4 } },
    { mods = "ALT", key = "6", action = wezterm.action { ActivateTab = 5 } },
    { mods = "ALT", key = "7", action = wezterm.action { ActivateTab = 6 } },
    { mods = "ALT", key = "8", action = wezterm.action { ActivateTab = 7 } },
    { mods = "ALT", key = "9", action = wezterm.action { ActivateTab = 8 } },
  },
}
