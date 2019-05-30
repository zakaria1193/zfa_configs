function reload_configs
{
  #clear env vars and everything else
  echo "Running installers.sh..."
  installers.sh

  echo ""
  echo "Sourcing zshrc..."
  source $HOME/.zshrc

  echo "Warning: PATH var is reset and refilled but environment vars may not be reset just refilled"
}

alias c="clear"
alias r="reload_configs"
alias sudo='sudo env "PATH=$PATH"'

if [[ $HOST == "FR308LL014" ]]
then
# Disable dualpoint stick mouse on keyboard due to false detction of button 2
BOARD_INIT="xinput --disable 'DELL08B8:00 0488:121F Mouse'"
else
BOARD_INIT=
fi

function init()
{
  $BOARD_INIT;

  "$HOME/.screenlayout/$1.sh"

  yes | wallpaper.sh 0;

  setxkbmap us_qwerty-fr

}

alias cd="cd -P"

[[ $(uname -m) == "x86_64" ]] && alias ls="exa"
[[ $(uname -m) == "x86_64" ]] && alias diff="difft"
alias grep="rg"
alias vim="nvim"
alias vimrc="vim $VIM_CONFIGS/init.vim"

alias make_path_arm="PATH=$PATH:$FIRMWARE_BITCLOUD/toolchain/arm-none-eabi/bin make"
alias make_preproc='CFLAGS=-E make'
MAKE_ERROR_PIPE='2>&1 | ccze -A | rg '\.c' | rg "error" | rg -v "pragma"'

alias t="task"
alias ta="task add"

alias opacity="gconftool-2 --set /apps/gnome-terminal/profiles/Default/background_darkness --type=float" # then a float btw 0 and 1

alias cat="bat"
alias catcat="command cat"

alias dmesg="dmesg -wH"

function backup
{
  cp $1 $1_backup
}

function find_and_replace()
{
  from=$1
  to=$2
  echo $1 $2
  rg -l $from | xargs sed -i s/$from/$to/g
}

alias swap="sudo swapoff /dev/sda5 && sync && sleep 5 && sudo swapon /dev/sda5"

alias update="sudo apt update && sudo apt upgrade -y"
alias update_pip="" # TODO
alias update_pip3="" # TODO

alias list="typeset -f" # show function implems

alias path='echo -e ${PATH//:/\\n}'
alias path_len="expr length $PATH"


alias xautolock='xautolock -time 10 -locker "systemctl suspend" &'
function xautolock_sleep
{
  time_s=$1
  if [ -z $time_s ]
  then
    echo 'need sleep time in minutes as arg'
    return
  fi
  time=$(($time_s*60))

    command="
    xautolock -disable;
    sleep $time;
    xautolock -enable;
    "
  nohup bash -x -c "$command" > .xautolog_sleep &
}

alias settings='env XDG_CURRENT_DESKTOP=GNOME gnome-control-center'

alias volumeset='pactl set-sink-volume 0' # then your value for 110% do 'volumeset 110'
function backlightset
{
   percent=$1
    if [ -z $percent ]
    then
      echo "need percent as arg"
      return
    fi

    if [ $percent -gt 100 ]
    then
      echo "percent too high"
      return
    fi

   max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
   brightness=$(($max*$percent/100))


   echo $brightness | tee /sys/class/backlight/intel_backlight/brightness
}

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
