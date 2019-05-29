function refresh_configs
{
  #clear env vars and everything else
  exec zsh
}

alias c="clear && refresh_configs"

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
  grep -l $from | xargs sed -i s/$from/$to/g
}

alias swap="sudo swapoff /dev/sda5 && sync && sleep 5 && sudo swapon /dev/sda5"

alias update="sudo apt update && sudo apt upgrade -y"

# python
alias ipython='ipython3'
