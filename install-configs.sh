#!/bin/bash

ZFA_CONFIGS="$HOME/my_repos/zfa_configs"
SHELL_CONFIGS="$ZFA_CONFIGS/shell"
I3_CONFIGS="$ZFA_CONFIGS/i3"

function symbolic-link()
{
  local file_=$1
  local from=$2
  local to=$3
  rm $to/$file_ -r
  ln -s $from/$file_ $to
  echo "symbolic link of $file from $from/$file_ to $to/$file_"
}

# ZSH config

function pull_zsh_config()
{
  echo "SHELL_CONFIGS=$SHELL_CONFIGS" > $HOME/.zshrc_paths
  symbolic-link '.zshrc'     $SHELL_CONFIGS           $HOME
  symbolic-link '.oh-my-zsh' $SHELL_CONFIGS/oh-my-zsh $HOME
}

function install_zsh()
{
  sudo apt-get install zsh
  # set zsh as default shell
  echo "setting zshs default shell"
  chsh -s /usr/bin/zsh
  echo "installing fonts"
  $ZFA_CONFIGS/shell/oh-my-zsh/.oh-my-zsh/fonts/install.sh
  echo ">>> Logout and login to your ubuntu session"
}

# i3 config
function pull_i3_config()
{
  $I3_CONFIGS/compile-i3-configs.sh
  symbolic-link 'config' $I3_CONFIGS "$HOME/.config/i3"
}

function install_i3()
{
  sudo apt remove dunst
  sudo apt install i3

}

function main()
{
  # install_zsh
  pull_zsh_config
  # install_i3
  # pull_i3_config
}

main $@