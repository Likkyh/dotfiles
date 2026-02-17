# dotfiles

Personal configuration files for CachyOS (Arch) with KDE Plasma, Zsh + Powerlevel10k, and Kitty terminal.

## Structure

The repository mirrors the target filesystem layout so install locations are self-documenting.

```
dotfiles/
├── config/          -> ~/.config/
│   ├── fastfetch/   System info display with custom CachyOS logo
│   └── kitty/       Kitty terminal — Arctic Sapphire theme, FiraCode Nerd Font, ligatures
├── home/            -> ~/
│   ├── .gitconfig   Git user identity
│   ├── .nanorc      Nano — syntax highlighting, line numbers, mouse support
│   ├── .p10k.zsh    Powerlevel10k prompt theme configuration
│   ├── .zshrc       Zsh config — auto-installs Oh-My-Zsh & p10k, loads plugins
│   └── .zshrc_aliases  CLI aliases (bat, lsd, modern replacements)
├── etc/
│   └── ssh/
│       └── sshd_config  Hardened SSH — key-only auth, no root login, Ed25519
├── kde-profiles/    KDE Plasma theme profile (manual import)
├── wallpaper/       Desktop wallpaper
└── system/          Package lists (native + AUR) for reference
```

## Install

```bash
git clone https://github.com/Likkyh/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Preview what will be linked
./install.sh --dry-run

# Create symlinks (existing files are backed up to *.bak)
./install.sh
```

The script symlinks `config/*` to `~/.config/` and `home/*` to `~/`. Files under `etc/` require root and are not linked automatically — the script prints the command to copy them manually.
