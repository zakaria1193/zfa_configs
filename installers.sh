#!/bin/bash

if [[ -z $ZFA_CONFIGS ]]; then
  echo "$ZFA_CONFIGS" path not set from paths file.
  echo if this is the first time its normal.
  echo if not there is a problem in zshrc
  source ~/my_repos/zfa_configs/paths
else
  source "$ZFA_CONFIGS"/paths
fi

device_name=$(cat /sys/devices/virtual/dmi/id/product_name)

function symlink() {
  local file_=$1
  local from=$2
  local to=$3
  rm "$to"/"$file_" -r -f
  echo ln -s "$from"/"$file_" "$to"
  ln -s "$from"/"$file_" "$to"
  echo "symbolic link of $file_ from $from/$file_ to $to/$file_"
}

function is_installed() {
  local program=$1
  return $(command -v "$program" >/dev/null)
}

################################################################################
# zsh and shell tools #
################################################################################
function install_zsh() {
  if is_installed zsh; then
    return
  fi

  sudo apt-get install zsh -y
  # set zsh as default shell
  echo "setting zshs default shell"
  chsh -s "$(command -v zsh)"

  echo ">>> Logout and login to your ubuntu session"

  echo "installing oh my zsh"
  zsh "$ZFA_CONFIGS"/shell/ohmyzsh/tools/install.sh

  git clone https://github.com/zakaria1193/zfa_work_tools.git "$ZFA_WORK_TOOLS"
}

function install_tools() {
  echo "installing fuzzy seach"
  "$ZFA_CONFIGS_TOOLS"/fzf/install

  echo "installing bat & rg"
  # https://askubuntu.com/questions/1290262/unable-to-install-bat-error-trying-to-overwrite-usr-crates2-json-which
  sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep

  echo "installing sg"
  cargo install ast-grep --locked

  sudo apt install ranger -y

  # Backlight control
  sudo apt install light -y

  sudo dpkg -i "$ZFA_CONFIGS"/tools/*.deb
}

function pull_zsh_config() {
  printf ">> Pulling zsh config from repo to system \n"
  echo "SHELL_CONFIGS=$SHELL_CONFIGS" >"$HOME"/.zshrc_paths
  symlink '.zshrc' "$SHELL_CONFIGS" "$HOME"
}

################################################################################
# udev rules #
################################################################################
function install_udev_rules {
  echo "copying user udev rules"
  sudo ln -sf "$UDEV_RULES"/*.rules /etc/udev/rules.d

  # RELOAD UDEV RULES
  sudo udevadm control --reload-rules && sudo udevadm trigger
}
################################################################################
# i3 config #
################################################################################
function install_i3() {
  /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
  sudo apt install ./keyring.deb
  echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
  sudo apt update
  sudo apt install i3
}
function install_sway() {
  sudo apt update
  sudo apt install sway
}
function install_window_manager() {
  # if is_installed i3; then
  #   echo i3 installed
  #   return
  # fi
  sudo apt-get update
  install_sway
  sudo apt install rofi -y       # launcher
  sudo apt install acpi -y       # battery reader
  sudo apt install lm-sensors -y # temperature reader
  sudo apt install compton -y    # for transparency
  sudo apt install nmtui -y

  echo 'installing i3 blocks from submodule repo'
  cd $I3BLOCKS_REPO
  git checkout master
  sudo apt install autoconf -y
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd -
}

function pull_i3_config() {
  printf "\n>> Pulling i3 config from repo to system \n"
  $I3_CONFIGS/compile-i3-configs.sh
  mkdir -p $HOME/.config/i3
  symlink 'config' $I3_CONFIGS "$HOME/.config/i3"
  #remove i3 config if in home folder
  if [[ -f "$HOME/.i3/config" ]]; then
    mv $HOME/.i3/config $HOME/.i3/config_deleted_$(date +%Y%M%d%H%m%S)
  fi

  mkdir -p $HOME/.config/i3blocks
  symlink 'config' $I3BLOCKS_CONFIG "$HOME/.config/i3blocks"

  printf "\n>> Pulling compton config from repo to system \n"
  symlink 'compton.conf' $COMPTON_CONFIG "$HOME/.config"
}

function pull_sway_config() {
  printf "\n>> Pulling sway config from repo to system \n"
  $SWAY_CONFIGS/compile-sway-configs.sh
  mkdir -p $HOME/.config/sway
  symlink 'config' $SWAY_CONFIGS "$HOME/.config/sway"
  #remove sway config if in home folder
  if [[ -f "$HOME/.sway/config" ]]; then
    mv $HOME/.sway/config $HOME/.sway/config_deleted_$(date +%Y%M%d%H%m%S)
  fi

  mkdir -p $HOME/.config/i3blocks
  symlink 'config' $I3BLOCKS_CONFIG "$HOME/.config/i3blocks"

  printf "\n>> Pulling compton config from repo to system \n"
  symlink 'compton.conf' $COMPTON_CONFIG "$HOME/.config"
}



################################################################################
# git tools #
################################################################################
function install_git {
  git config --global user.email "zakaria.fadli@netatmo.com"
  git config --global user.name "Zakaria Fadli"

  pip3 install --user gitpython sh

  # git
  sudo apt install git -y

  # git diff tool
  cargo install git-delta

  # Github / Gitlab tool
  sudo apt install gh
  sudo snap install glab

}

function pull_git_config {

  printf "\n>> Pulling git config from repo to system \n"
  symlink '.gitconfig' "$ZFA_CONFIGS/git" "$HOME"
  symlink '.gitignore_global' "$ZFA_CONFIGS/git" "$HOME"
  symlink '.gitconfig_work' "$ZFA_CONFIGS/git" "$HOME"
}

################################################################################
# sumblime text #
################################################################################
function install_vim {
  if is_installed neovim; then
    echo vim installed installed
  else
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
  fi

  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  # Universal ctags install
  # skip if ctags executable is found
  if [[ -x $(command -v ctags) ]]; then
    echo "ctags already installed"
  else
    curl -L https://github.com/thombashi/universal-ctags-installer/raw/master/universal_ctags_installer.sh | sudo bash
  fi

  install_vim_plugins
}

function install_nerdfonts {
  wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip &&
    cd ~/.local/share/fonts &&
    unzip JetBrainsMono.zip &&
    rm JetBrainsMono.zip &&
    fc-cache -fv
}

function install_vim_plugins {
  nvim '+Lazy! sync' +qall
  nvim +MasonUpdate +qall
  nvim +TSUpdate +qall
  nvim +TSUpdateSync +qall
}

function install_vscode {
  if is_installed code; then
    echo vscode installed
    return
  fi

  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg

  sudo apt update
  sudo apt install code -y
}

function pull_vim_config {
  printf "\n>> Pulling vim config from repo to system \n"
  mkdir $HOME/.config/nvim -p
  symlink $(basename $VIM_CONFIGS_FILE) $VIM_CONFIGS "$HOME/.config/nvim"
  symlink 'lua' $VIM_CONFIGS "$HOME/.config/nvim"
}

################################################################################
# alacritty #
#                           FIXME REPLACE BY KITTY
################################################################################
function install_terminal_emul {
  if is_installed alacritty; then
    echo alacritty installed
    return
  fi

  sudo add-apt-repository ppa:aslatter/ppa -y
  sudo apt install alacritty -y
  sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
  sudo add-apt-repository --remove ppa:aslatter/ppa -y

  # Clone themes
  mkdir -p "$HOME"/.config/alacritty
  git clone https://github.com/alacritty/alacritty-theme "$HOME"/.config/alacritty/themes
}

function pull_terminal_emul_config {
  printf "\n>> Pulling alacritty from repo to system \n"
  symlink '.alacritty.toml' $SHELL_CONFIGS "$HOME"

  # remove old config system (yml)
  rm "$HOME/.alacritty.yml" -f
}

################################################################################
# wireshark #
################################################################################
function install_wireshark {
  sudo add-apt-repository ppa:wireshark-dev/stable -y
  sudo apt install wireshark tshark -y

  # Be able to run wireshark as non root
  sudo dpkg-reconfigure wireshark-common
  sudo chmod +x /usr/bin/dumpcap

  # Sniffer tools
  pip3 install pyserial pyspinel
}

function pull_wireshark_config {
  # do not use symbolic link function since sudo is needed
  # printf "\n>> Pulling wireshark from repo to system \n"
  # rm $HOME/.wireshark -r -f
  # ln -s $ZFA_WORK_TOOLS/.wireshark $HOME
  true
}

################################################################################
# gdb #
################################################################################
function install_gdb {
  sudo apt install gdb-multiarch -y

  # gdb bundle is not maintained anymore
  # TODO install pycortex ndebug directly
}

function pull_gdb_config {
  true
}

################################################################################
# general #
################################################################################

function install_general {
  sudo apt update
  sudo apt install make curl feh git tig libxml2-utils jq xclip xsel ascii ripgrep arandr wget gpg -y
  sudo apt-get install software-properties-common -y

  sudo apt install zathura -y
  sudo apt install python3 python3-pip ipython3 python3-dev python-is-python3 -y
  sudo apt install python2 python2-dev -y
  sudo apt install gcc g++ make -y
  sudo apt install cargo -y
  sudo apt install clangd clangd-12 llvm -y
  sudo apt install minicom meld -y
  sudo apt install ccache -y
  sudo apt install ncdu -y
  sudo apt install htop -y
  sudo apt install docker docker-compose -y
  sudo apt install pass -y
  sudo apt install libssl-dev -y
  sudo apt install libfuse2 -y
  sudo apt install except -y

  sudo apt install network-manager bmon -y # for network monitor

  sudo apt install scrot viewnior -y # for capture

  # no sudo for docker
  sudo groupadd docker
  sudo usermod -aG docker $USER

  # Install node 18 (min needed for copilot)
  curl -fsSL https://deb.nodesource.com/setup_18.x | command sudo -E bash -
  sudo apt install nodejs
  sudo apt install npm yarn -y

  # install golang
  sudo apt install golang -y

  # install rust
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function install_general_no_graphics {
  sudo apt update
  sudo apt install make curl git tig jq xclip ascii minicom -y
  sudo apt install ripgrep fd-find -y
  sudo apt install gcc g++ make nodejs -y
  sudo apt install ccache -y
  sudo apt install except -y

  sudo sysctl -w kernel.dmesg_restrict=0
}

function install_apps {

  # install
  TARGET=google-chrome-stable_current_amd64.deb
  curl -L https://dl.google.com/linux/direct/$TARGET -o $TARGET
  sudo dpkg -i $TARGET
  rm $TARGET
}

################################################################################
################################################################################
function update() {
  sudo apt update
  sudo apt upgrade -y

  # For all submodules pull master
  cd $ZFA_CONFIGS
  for module in $(git submodule | awk '{print $2}'); do
    cd $module
    git pull origin master
    cd -
  done
  # Commit submodule changes
  git add .
  git commit -m "Submodules Update"

  install_vim_plugins
}
################################################################################

function main() {

  if [[ $1 == '-i' ]]; then
    git -C $ZFA_CONFIGS submodule update --init
    install_general
    install_zsh
    install_vscode
    install_git
    install_tools
    install_window_manager
    install_udev_rules
    install_terminal_emul
    install_wireshark
    install_gdb
    install_vim
    install_nerdfonts
    install_apps
    # pull_repos
  fi

  pull_zsh_config
  pull_sway_config
  pull_git_config
  pull_vim_config
  pull_terminal_emul_config
  pull_wireshark_config
  pull_gdb_config

  if [[ $1 == '-u' ]]; then
    update
  fi
}

################################################################################

function main_no_graphics() {
  if [[ $1 == '-i' ]]; then
    install_general_no_graphics
    install_zsh
    install_git
    install_tools
    install_vim
  fi

  pull_zsh_config
  pull_git_config
  pull_vim_config

  if [[ $1 == '-i' ]]; then
    vim +PlugInstall +qall
  fi
}

################################################################################
################################################################################
################################################################################

main $@
