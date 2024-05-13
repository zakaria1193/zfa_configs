#!/bin/sh
# Toggle dark and light themes for firefox, tmux, alacritty,
# and (neo)vim. Either run it from a shell or add a keybinding
# in tmux / alacritty

VIMLIGHTTHEME="background='light'"
VIMDARKTHEME="background='dark'"
VIMCONF="${VIM_CONFIGS}/lua/user/colorscheme.lua"

ALACRITTYLIGHTTHEME="github_light"
ALACRITTYDARKTHEME="google"
ALACRITTYCONF="${HOME}/.alacritty.toml"

# Git delta pager

# if arg given, use it as the theme (dark/light)
[ -n "$1" ] && CURRENT_MODE_USER="'$1'" && echo "User reqested mode: $CURRENT_MODE_USER"



# Toggle logic based on current mode
if [ "$CURRENT_MODE_USER" = "'light'" ]; then
  echo "Switching to light mode"

  echo "Changing alacritty theme to $ALACRITTYLIGHTTHEME"
  sed -i 's/'$ALACRITTYDARKTHEME'/'$ALACRITTYLIGHTTHEME'/' "$ALACRITTYCONF"

  echo "Changing vim theme to $VIMLIGHTTHEME"
  sed -i 's/'$VIMDARKTHEME'/'$VIMLIGHTTHEME'/' "$VIMCONF"
else
  echo "Switching to dark mode"

  echo "Changing alacritty theme to $ALACRITTYDARKTHEME"
  sed -i 's/'$ALACRITTYLIGHTTHEME'/'$ALACRITTYDARKTHEME'/' "$ALACRITTYCONF"

  echo "Changing vim theme to $VIMDARKTHEME"
  sed -i 's/'$VIMLIGHTTHEME'/'$VIMDARKTHEME'/' "$VIMCONF"
fi

