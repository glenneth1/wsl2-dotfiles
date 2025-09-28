# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Guix Home environment
if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

ZSH="/home/glenn/.oh-my-zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.
  plugins=(git z sudo zsh-autosuggestions history-substring-search colored-man-pages zsh-syntax-highlighting)
  
  source $ZSH/oh-my-zsh.sh
  
  # User configuration

# export MANPATH="/usr/local/man:$MANPATH"

  # You may need to manually set your language environment
  # export LANG=en_US.UTF-8
  #
  # Example aliases
  # alias zshconfig="mate ~/.zshrc"
  # alias ohmyzsh="mate ~/.oh-my-zsh"

  # SBCL with rlwrap history
  alias sbcl='rlwrap -H ~/.sbcl_history sbcl'
  
  # Guile with rlwrap history
  alias guile='rlwrap -H ~/.guile_history guile'
  
  alias delete_junk_files='find . -name "*:Zone.Identifier" -type f -delete'

  # Enable Powerlevel10k. Run "p10k configure" to customize.
  [[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh

# BEGIN Cascade zsh QoL
# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY SHARE_HISTORY

# history-substring-search keybindings
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Better ls defaults
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons'
else
  alias ls='ls --color=auto'
fi

# Source enhanced CLI tooling
[ -f ~/.zshrc.cli ] && source ~/.zshrc.cli
# END Cascade zsh QoL

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add WSL lib path for Windows integration
export PATH="$PATH:/usr/lib/wsl/lib"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# Zig Programming Language
export PATH="/opt/zig:$PATH"

# Automatically added for Guix environment detection
# Show [env] in prompt when in a Guix environment
if [[ -n "$GUIX_ENVIRONMENT" ]]; then
    # For Powerlevel10k and other themes that support custom segments
    export GUIX_ENV_INDICATOR="[env]"
    # Also modify PS1 as fallback for simpler prompts
    if [[ -n "$PS1" ]]; then
        PS1="$PS1 [env] "
    fi
fi

# Guix locale configuration
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
