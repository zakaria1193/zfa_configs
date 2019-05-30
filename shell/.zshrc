# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="honukai"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME=random
# ZSH_THEME_RANDOM_CANDIDATES=( "honukai" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
#DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
#export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
#
ZSH_CUSTOM="/home/zfadli/my_repos/zfa_configs/shell/zsh_custom"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  history
  zsh-syntax-highlighting
  colored-man-pages
  z
  #zsh-vi-mode
)

plugins_completions=(
  docker
  python
  pip
  common-aliases
  zsh-autosuggestions # broken with zsh vi mode (FIXME)
)

plugins_tools=(
  extract # extract $any_archive_file
  web-search # use it as google $something
  sprunge  # uploads piped content to sprung.us and gives you link
  copyfile # copies file into clipboard
)

plugins=(
  ${plugins[@]}
  ${plugins_completions[@]}
  ${plugins_tools[@]}
)

# enable OH MY ZSH (plugin manage)
source $ZSH/oh-my-zsh.sh


###############################################################################
# User configuration
# Enable my scripts and aliases
if [ -f $HOME/.zshrc_paths ]; then
  source $HOME/.zshrc_paths
else
  echo ".zshrc_paths wasn't found in $HOME (run install_configs.sh to get it"
fi

if [ -f $SHELL_CONFIGS/custom.zshrc ]; then
  source $SHELL_CONFIGS/custom.zshrc
else
  echo "$SHELL_CONFIGS/custom.zshrc wasn't found  (SHELL_CONFIGS = $SHELL_CONFIGS)"
fi



##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

#Choose the default pager
export PAGER="less -F -X"

# GIT completion # make it faster # see this
# https://stackoverflow.com/questions/9810327/zsh-auto-completion-for-git-takes-significant-amount-of-time-can-i-turn-it-off/9810485#9810485
 __git_files () {
     _wanted files expl 'local files' _files
 }

## For Make completion
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:make:*' tag-order 'targets'

# Use ripgrep as default search engine
export FZF_DEFAULT_COMMAND='rg --files'
# A single -u won’t respect .gitignore (etc.) files. Two -u flags will additionally search hidden files and directories.
#  Three -u flags will additionally search binary files.

TERM=xterm-256color # https://unix.stackexchange.com/questions/528323/what-uses-the-term-variable

EDITOR=/usr/local/bin/nvim
export EDITOR
ZVM_VI_EDITOR=$EDITOR # For vv command in normal vi mode

export PATH="$HOME/.poetry/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
