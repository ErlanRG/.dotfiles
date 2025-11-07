<h1 align="center">Erlan's Dotfiles</h1>

<p align="center">
  <img src="https://img.shields.io/github/last-commit/ErlanRG/.dotfiles?style=for-the-badge&logo=github&color=b4befe&logoColor=D9E0EE&labelColor=302D41" />
</p>

## Features

- **Shell:** Zsh with Oh My Zsh, along with a curated set of plugins and aliases for a powerful and efficient command-line experience.
- **Terminal:** Configurations for Kitty, WezTerm, and Ghostty, with a consistent and beautiful Catppuccin theme.
- **Window Managers:** Customized configurations for i3 and Niri, complete with scripts and themes.
- **Editors:** Neovim setup with Lua-based configuration, and settings for IdeaVim.
- **Other Tools:** Configurations for Git, Starship, Tmux, Yazi, and more.

## Structure

The repository is organized into the following directories:

- `core`: Contains the core configuration files for essential tools like `zsh`, `nvim`, `kitty`, etc.
- `wms`: Contains the configuration files for window managers like `i3` and `niri`.
- `install`: Contains the installation scripts for setting up the dotfiles.

## Installation

To install these dotfiles, you can use the provided setup script. The script will install the necessary packages and create the required symlinks.

```bash
git clone --depth 1 https://github.com/ErlanRG/.dotfiles.git $HOME
cd $HOME/.dotfiles/install
./setup.sh
```

The setup script will guide you through the installation process, allowing you to choose which window manager configuration to install.

## Scripts

This repository includes scripts to help manage the dotfiles:

- **`install/setup.sh`**: The main installation script that guides you through the setup process.
- **`install/scripts/wm-stow.sh`**: A script to manage window manager configurations. It can be used to `stow` (create symlinks) or `unstow` (remove symlinks) the configuration files for a specific window manager.

  **Usage:**
  ```bash
  ./install/scripts/wm-stow.sh <stow|unstow> <wm_name>
  ```

  **Example:**
  To stow the i3 configuration:
  ```bash
  ./install/scripts/wm-stow.sh stow i3
  ```

## Dependencies

The installation script will automatically install the required packages for the selected configuration. However, you will need to have `git` and `stow` installed on your system before running the script.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
