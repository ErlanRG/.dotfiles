<h1 align="center">Erlan's Dotfiles</h1>

<p align="center">
  <img src="https://img.shields.io/github/last-commit/ErlanRG/.dotfiles?style=for-the-badge&logo=github&color=b4befe&logoColor=D9E0EE&labelColor=302D41" />
</p>

## Features

- **Shell:** Zsh with a curated set of plugins and aliases for a powerful and efficient command-line experience.
- **Terminal:** Configurations for Kitty, WezTerm, and Ghostty, with a consistent and beautiful Catppuccin theme.
- **Window Managers:** Customized configurations for Hyprland, Niri, and Mango, complete with scripts and themes.
- **Editors:** Neovim setup with Lua-based configuration, and settings for IdeaVim.
- **Other Tools:** Configurations for Git, Starship, Tmux, Yazi, and more.

## Structure

The repository is organized into the following directories:

- `core`: Contains the core configuration files for essential tools like `zsh`, `nvim`, `kitty`, etc.
- `wms`: Contains the configuration files for the window managers `hyprland`, `niri` and `mango`, plus
  `wayland-common` — waybar and wofi fragments shared between them through committed symlinks.
- `install`: Contains the installation scripts for setting up the dotfiles.

## Installation

To install these dotfiles, you can use the provided setup script. The script will install the necessary packages and create the required symlinks.

```bash
git clone https://github.com/ErlanRG/.dotfiles.git $HOME/.dotfiles
$HOME/.dotfiles/install/setup.sh
```

Run bare, the script asks which window manager to install. It can also be driven directly:

```bash
./setup.sh --wm mango                  # skip the menu
./setup.sh --wm niri --dry-run         # print what would happen, change nothing
./setup.sh --wm mango --skip-stow      # packages only
./setup.sh --wm mango --skip-packages  # symlinks only
./setup.sh --list                      # list the known window managers
```

Every package is installed from the enabled repos with `pacman`; nothing is ever built from
the AUR. `paru` is installed as an ordinary package so `pacman -Syu` keeps it updated, but
the installer itself never calls it. Before touching the system the script checks that every
package resolves in an enabled repo, and stops with a list if any does not.

Adding a window manager means adding one line to `install/wms.conf` and a matching
`install/packages/<name>.packages`.

## Scripts

This repository includes scripts to help manage the dotfiles:

- **`install/setup.sh`**: The main installation script that guides you through the setup process.
- **`install/scripts/dot-stow`**: Manages the symlinks for `core` plus one window manager.
  It is also copied to `~/.local/bin`, so it works from anywhere once installed.

  **Usage:**
  ```bash
  dot-stow <stow|restow|unstow> <wm>
  ```

  **Example:**
  ```bash
  dot-stow stow mango     # link core + mango into $HOME
  dot-stow restow mango   # re-link after adding or renaming files
  dot-stow unstow mango   # remove the symlinks again
  ```

  Anything real that is already in the way is moved to `~/config_backup_<timestamp>/` first;
  symlinks the repo already owns are simply replaced. There is no `all` target on purpose —
  every window manager claims `~/.config/waybar` and `~/.config/wofi`, so only one can be
  stowed at a time.
- **`install/scripts/screenshot.sh`** and **`install/scripts/webapps`**: also installed to
  `~/.local/bin`.

## Dependencies

The installation script installs the required packages for the selected configuration. You need
`git`, `stow` and a CachyOS-style repo set (`cachyos`, `core`, `extra`, `multilib`) before running it.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
