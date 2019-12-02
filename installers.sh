#!/bin/bash

source ./paths
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

function is_installed()
{
  local program=$1
  return $(command -v $program >/dev/null)
}


################################################################################
                                # zsh and shell tools #
################################################################################
function install_zsh()
{
  if is_installed zsh; then
    return
  fi

  sudo apt-get install zsh -y
  # set zsh as default shell
  echo "setting zshs default shell"
  chsh -s /bin/zsh
  echo ">>> Logout and login to your ubuntu session"

  echo "installing fonts"
  $ZFA_CONFIGS/shell/oh-my-zsh/.oh-my-zsh/fonts/install.sh
}

function install_tools()
{
  if is_installed fzf; then
    echo fzf installed
  else
    echo "installing fuzzy seach"
    $ZFA_CONFIGS/tools/fzf/install
  fi


  if is_installed bat; then
    echo bat installed
  else
    echo "installing bat"
    sudo dpkg -i $ZFA_CONFIG/tools/bat_0.11.0_i386.deb
  fi


  # given host name choose config (fall back to a default config)
  if [[ $device_name == 'HP Notebook' ]]; then
    echo "install monitor backlight control (will work after reboot)"
    symbolic-link 20-intel.conf $I3_CONFIGS/backlight_intel_hp /usr/share/X11/xorg.conf.d
  fi
}

function pull_zsh_config()
{
  printf ">> Pulling zsh config from repo to system \n"
  echo "SHELL_CONFIGS=$SHELL_CONFIGS" > $HOME/.zshrc_paths
  symbolic-link '.zshrc'     $SHELL_CONFIGS           $HOME
  symbolic-link '.oh-my-zsh' $SHELL_CONFIGS/oh-my-zsh $HOME
}

################################################################################
                                # udev rules #
################################################################################
function install_udev_rules
{
  echo "copying user udev rules"
  sudo ln -sf $UDEV_RULES/*.rules /etc/udev/rules.d


  # find and replace for paths
  from='\$\$MY_UDEV_NOTIFY_SH\$\$'
  to='$MY_UDEV_NOTIFY_SH'
  sudo sed -i s/$from/$to/g /etc/udev/rules.d/my-udev-notify.rules

  # RELOAD UDEV RULES
  sudo udevadm control --reload-rules && sudo udevadm trigger
}
################################################################################
                                # i3 config #
################################################################################
function install_i3()
{
  if is_installed i3; then
    echo i3 instaleld installed
    return
  fi

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

################################################################################
                                # git tools #
################################################################################
function install_git
{
  # gita for command line
  # pip3 install gita --user
  # pip3 install gitpython --user

  # mgitstatus and gitbreather are the chosen solution for now

  # rebase editor installer
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - # installs NPM
  sudo npm install -g rebase-editor
  git config --global sequence.editor "rebase-editor -s -c -m '> ' --no-alternate-screen"
  # TODO add git autofixup installer

  return
}

function pull_git_config
{
  # TODO copy config from work and symlink to it
  return
}
################################################################################
                                # sumblime text #
################################################################################
function install_sublime
{
  if is_installed subl; then
    echo subl installed installed
    return
  fi

  echo 'Installing sublime text'
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get update
  sudo apt-get install sublime-text
}

function pull_sublime_config
{
  printf "\n>> Pulling sublime from repo to system \n"
  symbolic-link 'User' $SUBLIME_CONFIG_REPO "$HOME/.config/sublime-text-3/Packages"
}


################################################################################
                                # sumblime text #
################################################################################
function install_vim
{
  if is_installed vim; then
    echo vim installed installed
    return
  fi

  sudo apt install vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

function pull_vim_config
{
  printf "\n>> Pulling sublime from repo to system \n"
  symbolic-link '.vimrc' $VIM_CONFIGS "$HOME"
}

################################################################################
                                # urxvt #
################################################################################
function install_urxvt
{
  if is_installed urxvt; then
    echo urxvt installed installed
    return
  fi

  apt-get install rxvt-unicode
  sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt

  # prepare dir for plugins
  mkdir ~/.urxvt/
  mkdir ~/.urxvt/ext/
}

function pull_urxvt_config
{
  printf "\n>> Pulling urxvt from repo to system \n"
  symbolic-link '.Xresources' $SHELL_CONFIGS "$HOME"
  xrdb -merge ~/.Xresources
}


function main()
{
  if [[ $1 == '-i' ]]; then
    install_zsh
    install_shell_tools
    install_i3
    install_sublime
    install_udev_rules
    install_urxvt
  fi

  pull_zsh_config
  pull_i3_config
  pull_git_config
  pull_sublime_config
  pull_vim_config
  pull_urxvt_config

  if [[ $1 == '-i' ]]; then
    vim +PluginInstall +qall
  fi
}

function main_no_graphics()
{
  if [[ $1 == '-i' ]]; then
    install_zsh
    install_shell_tools
  fi

  pull_zsh_config
  pull_git_config
  pull_vim_config

  if [[ $1 == '-i' ]]; then
    vim +PluginInstall +qall
  fi
}

main $@
