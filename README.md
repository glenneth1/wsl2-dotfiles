# WSL2 Dotfiles - Managed with Stash

This repository contains my personal dotfiles for WSL2 Ubuntu, managed using an enhanced `stash` utility - a GNU Stow replacement written in Guile Scheme.

## Quick Setup

### On a New WSL2 Machine
```bash
# Clone this repository
git clone git@github.com:glenneth1/wsl2-dotfiles.git ~/.files
cd ~/.files

# Deploy all configurations using stash
./stash -d
```

## Repository Structure

```
~/.files/
├── README.md                    # This file
├── STASH_GUIDE.md              # Stash utility documentation
├── build-sbcl.sh               # SBCL build script
├── guix_install.sh             # Guix installation script
├── sbclrc                      # SBCL configuration
├── zshrc                       # ZSH shell configuration
├── p10k.zsh                    # Powerlevel10k theme
├── fzf.zsh                     # FZF integration
├── config/
│   ├── guix/
│   │   ├── channels.scm        # Guix channels
│   │   └── home-configuration.scm # Guix home config
│   └── common-lisp/
│       └── source-registry.conf # Common Lisp registry
└── emacs.d/
    ├── config.org              # Emacs configuration (org-mode source)
    ├── early-init.el           # Emacs early initialization
    └── custom.el               # Emacs custom settings
```

## Managed Configurations

This repository manages:
- **Shell**: ZSH configuration, Powerlevel10k theme, FZF integration
- **Emacs**: Org-mode configuration source, initialization files
- **Guix**: System and home configurations, channels
- **Development**: SBCL, Common Lisp registry
- **Scripts**: Build tools and installation scripts

## Stash Utility

This repository uses a custom GNU Stow replacement written in Guile Scheme with enhanced features:
- Intelligent file vs directory level stashing
- Metadata tracking for restoration
- GNU Stow-like deployment capabilities
- Clean path structure preservation

### Usage Examples
```bash
# Deploy all packages
./stash -d

# Deploy specific configurations
./stash shell    # Shell configs only
./stash emacs    # Emacs configs only

# Stash new files
./stash -s ~/.new-config -t ~/.files

# Restore files if needed
./stash -R -s ~/.files/config/app/file.conf
```

## WSL2 Specific

This dotfiles setup is optimized for:
- WSL2 Ubuntu environment
- Guix package manager integration
- Development workflow with Emacs + Lisp
- Modern shell experience with ZSH + Powerlevel10k

## Links

- **Stash Repository**: https://codeberg.org/glenneth/stash
- **This Dotfiles Repository**: https://github.com/glenneth1/wsl2-dotfiles

---

**Powered by Stash** - A GNU Stow replacement in Guile Scheme
