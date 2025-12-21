# Tmux Configuration

```
████████╗███╗   ███╗██╗   ██╗██╗  ██╗
╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝
   ██║   ██╔████╔██║██║   ██║ ╚███╔╝
   ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗
   ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗
   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝
```

Egrace's personal tmux configuration optimized for **WSL + Neovim** workflow.

## Features

- **Catppuccin Macchiato** theme
- **Vi-style** keybindings in copy mode
- **Mouse support** for scrolling, pane selection, and resizing
- **True color** and undercurl support
- **Session persistence** with auto-save every minute
- **Custom status modules** for system monitoring

## Status bar section
| Status Bar |
|------------|
| Country • IP • Application • CPU • Memory • Session • Uptime |


## Installation

> **Note:** Tested on Debian 13 only.

1. Clone or copy this repository to `~/.config/tmux/`:
```bash
git clone git@github.com:egracens/tmux-config.git ~/.config/tmux
```

2. Run the setup script:
```bash
cd ~/.config/tmux
chmod +x setup.sh
./setup.sh
```

The setup script will:
1. Install dependencies (`tmux`, `ncurses-term`, `git`)
2. Create symlink `~/.tmux.conf`
3. Install TPM (Tmux Plugin Manager)
4. Install all plugins

## File Structure

```
~/.config/tmux/
├── tmux.conf           # Main configuration
├── setup.sh            # Installation script
├── README.md           # This file
├── modules/            # Custom Catppuccin status modules
│   ├── country.conf    # Country indicator
│   ├── ip.conf         # IP address
│   └── memory.conf     # RAM usage
├── scripts/            # Helper scripts
│   ├── country_info.sh # Fetches country code
│   ├── ip_info.sh      # Fetches public IP
│   └── ram_info.sh     # Displays RAM usage
└── plugins/            # TPM plugins (auto-installed)
```

## Keybindings

> Prefix key: `Ctrl + b`

### Windows & Panes

| Keybinding | Action |
|------------|--------|
| `prefix + c` | New window |
| `prefix + \|` | Split horizontal |
| `prefix + _` | Split vertical |
| `prefix + r` | Rename window |
| `prefix + R` | Rename session |
| `prefix + +` | Zoom pane |
| `prefix + x` | Kill pane |
| `prefix + X` | Kill window (confirm) |
| `prefix + q` | Kill server (confirm) |

### Navigation (no prefix)

| Keybinding | Action |
|------------|--------|
| `Ctrl + h` | Move to left pane |
| `Ctrl + j` | Move to pane below |
| `Ctrl + k` | Move to pane above |
| `Ctrl + l` | Move to right pane |
| `Ctrl + Shift + h` | Resize pane left |
| `Ctrl + Shift + j` | Resize pane down |
| `Ctrl + Shift + k` | Resize pane up |
| `Ctrl + Shift + l` | Resize pane right |

### Copy Mode

| Keybinding | Action |
|------------|--------|
| `prefix + v` | Enter copy mode |
| `v` | Start selection |
| `y` | Yank selection |

### Session Management

| Keybinding | Action |
|------------|--------|
| `prefix + Ctrl + s` | Save session |
| `prefix + Ctrl + r` | Restore session |

### Plugins

| Keybinding | Action |
|------------|--------|
| `prefix + I` | Install plugins |
| `prefix + U` | Update plugins |

## Plugins

| Plugin | Description |
|--------|-------------|
| [tpm](https://github.com/tmux-plugins/tpm) | Plugin manager |
| [tmux-cpu](https://github.com/tmux-plugins/tmux-cpu) | CPU and RAM monitoring |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Session save/restore |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Auto-save sessions |
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Catppuccin theme |

## Status Bar Modules

| Module | Description | Color |
|--------|-------------|-------|
| Country | Current country code | Peach |
| IP | Public IP address | Green |
| Application | Current application | - |
| CPU | CPU usage percentage | Yellow |
| Memory | RAM usage (used/total) | Blue |
| Session | Session name | - |
| Uptime | System uptime | - |

## Requirements

- tmux 3.0+
- Nerd Font (for icons)
- Debian/Ubuntu (for setup script)

## Customization

### Change Theme Flavor

Edit `tmux.conf` and change:
```bash
set -g @catppuccin_flavor 'macchiato'  # latte, frappe, macchiato, mocha
```

### Add/Remove Status Modules

Edit the status bar layout section in `tmux.conf`:
```bash
set -g status-right "#{E:@catppuccin_status_module_name}"
```

## License

MIT
