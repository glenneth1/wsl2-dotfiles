# Enhanced Stash Dotfiles Management Guide

This guide shows how to use the enhanced Stash utility for comprehensive dotfiles management with GNU Stow-like functionality.

## Quick Start

### 1. Collect Your Dotfiles
```bash
# Run the collection script
chmod +x ~/.files/collect-dotfiles.sh
~/.files/collect-dotfiles.sh
```

### 2. Initialize Git Repository
```bash
cd ~/.files
git init
git add .
git commit -m "Initial dotfiles collection"
```

### 3. Deploy Dotfiles (GNU Stow-like)
```bash
# Deploy all packages
cd ~/.files && stash -d

# Deploy specific package
cd ~/.files && stash shell
```

## Enhanced Stash Features

### 1. Traditional Stashing (Move files to storage)
```bash
# Move and symlink individual files
stash -s ~/.zshrc -t ~/.files/shell/zshrc
stash -s ~/.gitconfig -t ~/.files/git/gitconfig

# Interactive mode
stash -s ~/.config/bat -i

# Recursive stashing
stash -s ~/.emacs.d -t ~/.files/emacs -r
```

### 2. GNU Stow-like Deployment
```bash
# Deploy all packages from dotfiles directory
cd ~/.files && stash -d

# Deploy specific package
cd ~/.files && stash shell    # Deploys shell/ package
cd ~/.files && stash emacs    # Deploys emacs/ package
cd ~/.files && stash config   # Deploys config/ package
```

### 3. Dot Syntax (Reverse Symlinking)
```bash
# Create symlink from current directory to home
cd ~/.files/shell && stash .
# Creates ~/.shell -> ~/.files/shell

cd ~/.files/emacs && stash .
# Creates ~/.emacs -> ~/.files/emacs
```

## Directory Structure

Your `.files` directory should be organized like this:

```
~/.files/
├── shell/              # Shell configuration
│   ├── zshrc          # ~/.zshrc
│   ├── p10k.zsh       # ~/.p10k.zsh
│   ├── zshrc.cli      # ~/.zshrc.cli
│   └── fzf.zsh        # ~/.fzf.zsh
├── emacs/             # Emacs configuration
│   ├── config.org     # ~/.emacs.d/config.org
│   ├── config.el      # ~/.emacs.d/config.el
│   ├── early-init.el  # ~/.emacs.d/early-init.el
│   └── themes/        # ~/.emacs.d/themes/
├── config/            # XDG config directory
│   ├── guix/          # ~/.config/guix/
│   ├── bat/           # ~/.config/bat/
│   └── common-lisp/   # ~/.config/common-lisp/
├── git/               # Git configuration
│   └── gitconfig      # ~/.gitconfig
├── scripts/           # Utility scripts
│   ├── build-sbcl.sh  # ~/build-sbcl.sh
│   └── guix_install.sh # ~/guix_install.sh
└── lisp/              # Lisp configuration
    └── sbclrc         # ~/.sbclrc
```

## Workflow Examples

### Initial Setup (First Time)
```bash
# 1. Collect existing dotfiles
~/.files/collect-dotfiles.sh

# 2. Initialize git repo
cd ~/.files
git init
git add .
git commit -m "Initial dotfiles"

# 3. Push to remote (optional)
git remote add origin https://github.com/yourusername/dotfiles.git
git push -u origin main
```

### New Machine Setup
```bash
# 1. Clone dotfiles repo
git clone https://github.com/yourusername/dotfiles.git ~/.files

# 2. Deploy all dotfiles
cd ~/.files && stash -d

# 3. Install additional dependencies as needed
```

### Adding New Dotfiles
```bash
# Method 1: Stash existing file
stash -s ~/.vimrc -t ~/.files/vim/vimrc

# Method 2: Copy to dotfiles and deploy
cp ~/.tmux.conf ~/.files/misc/tmux.conf
cd ~/.files && stash misc
```

### Updating Dotfiles
```bash
# Edit files in ~/.files/ directory
vim ~/.files/shell/zshrc

# Changes are automatically reflected via symlinks
# Commit changes
cd ~/.files
git add -A
git commit -m "Update shell configuration"
git push
```

## Package Organization Tips

### Shell Package (`~/.files/shell/`)
- `zshrc` → `~/.zshrc`
- `bashrc` → `~/.bashrc`
- `p10k.zsh` → `~/.p10k.zsh`
- `profile` → `~/.profile`

### Config Package (`~/.files/config/`)
Creates `~/.config/` subdirectories:
- `guix/` → `~/.config/guix/`
- `bat/` → `~/.config/bat/`
- `git/` → `~/.config/git/`

### Emacs Package (`~/.files/emacs/`)
- `config.org` → `~/.emacs.d/config.org`
- `early-init.el` → `~/.emacs.d/early-init.el`
- `themes/` → `~/.emacs.d/themes/`

## Advanced Usage

### Selective Deployment
```bash
# Deploy only shell configs
cd ~/.files && stash shell

# Deploy only emacs configs
cd ~/.files && stash emacs
```

### Backup Before Deployment
```bash
# Backup existing configs
mkdir ~/dotfiles-backup
cp -r ~/.config ~/dotfiles-backup/
cp ~/.zshrc ~/dotfiles-backup/

# Then deploy
cd ~/.files && stash -d
```

### Ignore Patterns
Create `.stashignore` files to exclude certain files:
```bash
# In ~/.files/emacs/.stashignore
*.elc
auto-save-list/
elpa/
straight/build/
```

## Troubleshooting

### Symlink Conflicts
If deployment fails due to existing files:
```bash
# Check what exists
ls -la ~/.zshrc

# Remove conflicting file if safe
rm ~/.zshrc

# Retry deployment
cd ~/.files && stash shell
```

### Broken Symlinks
```bash
# Find broken symlinks
find ~ -type l -exec test ! -e {} \; -print

# Remove broken symlinks
find ~ -type l -exec test ! -e {} \; -delete
```

### Permission Issues
```bash
# Fix permissions on dotfiles
chmod -R u+rw ~/.files/
chmod +x ~/.files/scripts/*
```

This enhanced stash provides the best of both worlds: traditional file organization through stashing and modern dotfiles deployment like GNU Stow!
