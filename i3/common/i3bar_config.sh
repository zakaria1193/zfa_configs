bar {
  # status_command i3status
  # what i prefer to use is the non defauilt i3ibar that is i3blocks -> update submodules of my config file
  status_command SCRIPT_DIR=$I3BLOCKS_SCRIPTS_DIR i3blocks
  # status_command 2>/tmp/i3blocks.err SCRIPT_DIR=$I3BLOCKS_SCRIPTS_DIR  /usr/bin/i3blocks -vvv | tee /tmp/i3blocks.out
  font pango:System San Fransisco Display 7.5

  colors {
    # separator          #268bd2
    # background         #002b36
    # statusline         #839496
    focused_workspace  #fdf6e3 #6c71c4 #fdf6e3
    active_workspace   #fdf6e3 #6c71c4 #fdf6e3
    inactive_workspace #002b36 #586e75 #002b36
    urgent_workspace   #d33682 #d33682 #fdf6e3
  }
}
