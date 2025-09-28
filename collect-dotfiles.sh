#!/bin/bash

# Dotfiles Collection Script for Stash
# This script helps identify and organize dotfiles for version control

echo "=== Dotfiles Collection for Stash ==="
echo

# Create directory structure
mkdir -p ~/.files/{shell,emacs,config,scripts,git,lisp,misc}

echo "📁 Created directory structure in ~/.files/"
echo

# Function to safely copy files
safe_copy() {
    local src="$1"
    local dest="$2"
    local name="$3"
    
    if [[ -e "$src" ]]; then
        if [[ -e "$dest" ]]; then
            echo "⚠️  $name already exists in dotfiles, skipping"
        else
            cp -r "$src" "$dest"
            echo "✅ Copied $name"
        fi
    else
        echo "❌ $name not found at $src"
    fi
}

echo "🔍 Collecting dotfiles..."
echo

# Shell configuration files
echo "--- Shell Configuration ---"
safe_copy ~/.zshrc ~/.files/shell/zshrc "ZSH configuration"
safe_copy ~/.p10k.zsh ~/.files/shell/p10k.zsh "Powerlevel10k theme"
safe_copy ~/.zshrc.cli ~/.files/shell/zshrc.cli "ZSH CLI config"
safe_copy ~/.fzf.zsh ~/.files/shell/fzf.zsh "FZF integration"
safe_copy ~/.bashrc ~/.files/shell/bashrc "Bash configuration"
safe_copy ~/.shell.pre-oh-my-zsh ~/.files/shell/shell.pre-oh-my-zsh "Pre-OMZ shell config"

# Git configuration
echo "--- Git Configuration ---"
safe_copy ~/.gitconfig ~/.files/git/gitconfig "Git global config"

# Emacs configuration (selective copy of important files)
echo "--- Emacs Configuration ---"
if [[ -d ~/.emacs.d ]]; then
    mkdir -p ~/.files/emacs
    # Copy main config files
    safe_copy ~/.emacs.d/config.org ~/.files/emacs/config.org "Emacs Org config"
    safe_copy ~/.emacs.d/config.el ~/.files/emacs/config.el "Emacs Lisp config"
    safe_copy ~/.emacs.d/early-init.el ~/.files/emacs/early-init.el "Emacs early init"
    safe_copy ~/.emacs.d/custom.el ~/.files/emacs/custom.el "Emacs custom variables"
    
    # Copy themes directory
    if [[ -d ~/.emacs.d/themes ]]; then
        safe_copy ~/.emacs.d/themes ~/.files/emacs/themes "Custom themes"
    fi
    
    echo "ℹ️  Note: Only essential Emacs files copied. Packages will be managed by package manager."
fi

# XDG Config directory (selective)
echo "--- XDG Configuration ---"
safe_copy ~/.config/guix ~/.files/config/guix "Guix configuration"
safe_copy ~/.config/bat ~/.files/config/bat "Bat configuration"
safe_copy ~/.config/common-lisp ~/.files/config/common-lisp "Common Lisp config"

# Scripts
echo "--- Scripts ---"
safe_copy ~/build-sbcl.sh ~/.files/scripts/build-sbcl.sh "SBCL build script"
safe_copy ~/guix_install.sh ~/.files/scripts/guix_install.sh "Guix install script"
safe_copy ~/fzf-git.sh ~/.files/scripts/fzf-git.sh "FZF Git integration"

# Lisp configuration
echo "--- Lisp Configuration ---"
safe_copy ~/.sbclrc ~/.files/lisp/sbclrc "SBCL configuration"

# Other important files
echo "--- Miscellaneous ---"
safe_copy ~/.authinfo.gpg ~/.files/misc/authinfo.gpg "Auth info (encrypted)"

echo
echo "🎉 Dotfiles collection complete!"
echo
echo "📋 Summary of collected files:"
find ~/.files -type f | sort
echo
echo "🔧 Next steps:"
echo "1. Review the collected files in ~/.files/"
echo "2. Initialize git repository: cd ~/.files && git init"
echo "3. Add files to git: git add ."
echo "4. Commit: git commit -m 'Initial dotfiles collection'"
echo "5. Use enhanced stash to create symlinks"
