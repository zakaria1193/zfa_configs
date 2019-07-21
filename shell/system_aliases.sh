function reload_configs
{
  #clear env vars and everything else
  cd $HOME
  install-configs.sh
  exec zsh

  # FIXME go back to old directory
  # or find a better way to do this by editing PATH in ~/profile? instead of zshrc
  # and run simply a light script for zshrc that doesn't source paths but only reloades aliases
}

alias c="clear"
alias r="reload_configs"

alias make_path_arm="PATH=$PATH:$FIRMWARE_BITCLOUD/toolchain/arm-none-eabi/bin make"
alias make_preproc='CFLAGS=-E make'
MAKE_ERROR_PIPE="2>&1 | ccze -A | ag '\.c' | grep "error" | grep -v "pragma""

alias t="task"
alias ta="task add"

alias wl="watch lsusb"
alias opacity="gconftool-2 --set /apps/gnome-terminal/profiles/Default/background_darkness --type=float" # then a float btw 0 and 1

alias cat="bat"

function find_and_replace()
{
  from=$1
  to=$2
  echo $1 $2
  ag -l $from | xargs sed -i s/$from/$to/g
}

alias swap="sudo swapoff /dev/sda5 && sync && sleep 5 && sudo swapon /dev/sda5"

alias update="sudo apt update && sudo apt upgrade -y"

alias list="typeset -f find_and_replace" # show function implems