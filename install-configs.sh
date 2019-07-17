#!/bin/bash

source paths
device_name=$(cat /sys/devices/virtual/dmi/id/product_name)

function symbolic-link()
{
  local file_=$1
  local from=$2
  local to=$3
  rm $to/$file_ -r -f
  ln -s $from/$file_ $to
  echo "symbolic link of $file from $from/$file_ to $to/$file_"
}

# ZSH config

function pull_zsh_config()
{
  printf ">> Pulling zsh config from repo to system \n"
  echo "SHELL_CONFIGS=$SHELL_CONFIGS" > $HOME/.zshrc_paths
  symbolic-link '.zshrc'     $SHELL_CONFIGS           $HOME
  symbolic-link '.oh-my-zsh' $SHELL_CONFIGS/oh-my-zsh $HOME
}

function install_zsh()
{
  sudo apt-get install zsh -y
  # set zsh as default shell
  echo "setting zshs default shell"
  chsh -s /bin/zsh
  echo ">>> Logout and login to your ubuntu session"
}

function install_shell_tools()
{
  echo "installing fonts"
  $ZFA_CONFIGS/shell/oh-my-zsh/.oh-my-zsh/fonts/install.sh
  echo "installing fuzzy seach"
  $ZFA_CONFIGS/tools/fzf/install
  echo "installing bat"
  sudo dpkg -i $ZFA_CONFIG/tools/bat_0.11.0_i386.deb

  # given host name choose config (fall back to a default config)
  if [[ $device_name == 'HP Notebook' ]]; then
    echo "install monitor backlight control (will work after reboot)"
    symbolic-link 20-intel.conf $I3_CONFIGS/backlight_intel_hp /usr/share/X11/xorg.conf.d
  fi
}

# i3 config
function pull_i3_config()
{
  printf "\n>> Pulling i3 config from repo to system \n"
  $I3_CONFIGS/compile-i3-configs.sh
  mkdir -p $HOME/.config/i3
  symbolic-link 'config' $I3_CONFIGS "$HOME/.config/i3"
  #remove i3 config if in home folder
  if [[ -f "$HOME/.i3/config" ]]; then
    mv $HOME/.i3/config $HOME/.i3/config_deleted_$(date +%Y%M%d%H%m%S)
  fi

  mkdir -p $HOME/.config/i3blocks
  symbolic-link 'config' $I3BLOCKS_CONFIG "$HOME/.config/i3blocks"
}

function install_i3()
{
  sudo apt remove dunst
  sudo apt install i3 -y
  sudo apt install rofi -y # launcher
  sudo apt install acpi -y # battery reader
  sudo apt install lm-sensors -y # temperature reader

  echo 'installing i3 blocks from submodule repo'
  sudo apt remove i3-blocks
  cd $I3BLOCKS_REPO
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd -
}

function install_git
{
  # install gita
  pip3 install gita --user

  # add git rebase editor installer
}

function pull_git_config
{
  # refresh all my repos to gita
  find $MY_REPOS -name ".git" -type d | sed s/'\/.git'// > /tmp/gita_repos
  find $REPOS -name ".git" -type d | sed s/'\/.git'// >> /tmp/gita_repos
  BLACKLIST=(
    openocd,
    )
  for x in $BLACKLIST; do
    sed -i "/$x/d" /tmp/gita_repos
  done
  cat /tmp/gita_repos | xargs python3 -m gita add
  echo gita ls:
  gita ls
}

function main()
{
  # install_zsh
  # install_shell_tools
  # install_i3
  pull_zsh_config
  pull_i3_config
}

main $@