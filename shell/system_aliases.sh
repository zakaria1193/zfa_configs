function reload_configs
{
  #clear env vars and everything else
  installers.sh
  source $HOME/.zshrc
}

alias c="clear"
alias r="reload_configs"

alias cd="cd -P"
alias ls="exa"

alias make_path_arm="PATH=$PATH:$FIRMWARE_BITCLOUD/toolchain/arm-none-eabi/bin make"
alias make_preproc='CFLAGS=-E make'
MAKE_ERROR_PIPE='2>&1 | ccze -A | ag '\.c' | grep "error" | grep -v "pragma"'

alias t="task"
alias ta="task add"

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

alias list="typeset -f" # show function implems

alias path='echo -e ${PATH//:/\\n}'
alias path_len="expr length $PATH"


function xautolock_sleep_deamon
{
  time=$1
  xautolock -disable
  sleep $time
  xautolock -enable
}

function xautolock_sleep
{
  time=$1
  if [ -z $time ]
  then
    echo 'need sleep time in minutes as arg'
    return
  bash export -f xautolock_sleep_deamon
  fi
  nohup bash -c xautolock_sleep_deamon $time &
}

alias settings='env XDG_CURRENT_DESKTOP=GNOME gnome-control-center'

alias volumeset='pactl set-sink-volume 0' # then your value for 110% do 'volumeset 110'

alias rotate_left="xrandr --output DP-2 --rotate left"
alias rotate_normal="xrandr --output DP-2 --rotate normal"



kill_port(){
    if [ $# -eq 0 ]; then
        echo "No arguments provided"
        echo "provide port of service you wish to kill"
        exit 1
    fi
    fuser -k $1/tcp
}
