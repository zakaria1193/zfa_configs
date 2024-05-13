# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:System San Fransisco Display 9


# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 8

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn’t scale on retina/hidpi displays.

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec i3-sensible-terminal

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
# -i for ignore case and - for lines mode (more visible is better)
# bindsym $mod+d exec dmenu_run -i -l 20
# rofi is a better alternative
bindsym $mod+d exec rofi -show run
bindsym $mod+shift+d exec rofi -show window


# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+v split h
# split in vertical orientation
bindsym $mod+h split v

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+t layout tabbed
bindsym $mod+e layout toggle split

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+q focus parent
# focus the child container
#bindsym $mod+c focus child # doesnt work

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3) (might take two)
bindsym $mod+Shift+r exec $COMPILE_I3_CONFIG_SCRIPT; restart

# windows fun actions
bindsym $mod+Shift+f floating toggle
bindsym $mod+Shift+s sticky toggle
bindsym $mod+f fullscreen

# resize window (you can also use the mouse for that)
bindsym $mod+r mode "resize"

mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

# stay within output boundaries
force_focus_wrapping no

# handle multiple outputs
bindsym $mod+m focus output left
bindsym $mod+shift+m move workspace to output left

# misc settings
focus_follows_mouse yes
popup_during_fullscreen smart
workspace_auto_back_and_forth yes


set $bg-color            #044000
set $inactive-bg-color   #2f343f
set $text-color          #ffffff
set $inactive-text-color #676E7D
set $urgent-bg-color     #E53935
set $urgent-color        #ffffff
set $bar-bg-color        #000000

# window colors
#                       border              background         text                   indicator
client.focused          $bg-color           $bg-color          $text-color            #156900
client.unfocused        $inactive-bg-color  $inactive-bg-color $inactive-text-color   #156900
client.focused_inactive $inactive-bg-color  $inactive-bg-color $inactive-text-color   #156900
client.urgent           $urgent-bg-color    $urgent-bg-color   $urgent-color          #156900

### Scratchpad
# Make the currently focused window a scratchpad
bindsym $mod+shift+p move scratchpad

# Show the first scratchpad window
bindsym $mod+p scratchpad show

bindsym Print exec "scrot /tmp/screenshot-$(date +%F_%T).png -e 'xclip -selection c -t image/png < $f'"
bindsym Shift+Print --release exec "scrot -s /tmp/screenshot-$(date +%F_%T).png -e 'xclip -selection c -t image/png < $f'"

## i3 gaps specific
for_window [class="^.*"] border pixel 1

gaps inner 2
gaps outer 1

# Only enable gaps on a workspace when there is at least one container
smart_gaps on

# Activate smart borders (always)
smart_borders on

# Hide edge borders only if there is one window with no gaps
hide_edge_borders smart_no_gaps
# Pulse Audio controls
# bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
# bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
# bindsym XF86AudioMute        exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound
bindsym XF86AudioRaiseVolume exec amixer -q -D pulse sset Master 5%+ && pkill -RTMIN+10 i3blocks
bindsym XF86AudioLowerVolume exec amixer -q -D pulse sset Master 5%- && pkill -RTMIN+10 i3blocks
bindsym XF86AudioMute exec amixer -q -D pulse sset Master toggle && pkill -RTMIN+10 i3blocks

# Brightness
bindsym XF86MonBrightnessUp exec light -A 20
bindsym XF86MonBrightnessDown exec light -U 20

# Media player controls
bindsym XF86AudioPlay  exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext  exec playerctl next
bindsym XF86AudioPrev  exec playerctl previous


# caps lock and num lock to status bar
bindsym --release Caps_Lock exec pkill -SIGRTMIN+11 i3blocks
bindsym --release Num_Lock  exec pkill -SIGRTMIN+11 i3blocks

# logout i3 (logs you out of your X session)
bindsym $mod+Shift+l exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

bindsym $mod+l exec $LOCK_SCRIPT

# exec at startup

# exec --no-startup-id blueman-applet
exec_always --no-startup-id nm-applet blueman-applet
exec_always  --no-startup-id yes | $WALLPAPER_SCRIPT
# exec_always  --no-startup-id  compton # compton is needed for transparency

# always remove dunst (keep default notifications)
# for always remove appmenu-qt5 (keep barre de menu)
# no desktop with nautilus: gsettings set org.gnome.desktop.background show-desktop-icons false

#enable numpad
exec  --no-startup-id setxkbmap -option keypad:pointerkeys
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

# switch to workspace
bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+6 workspace number 6
bindsym $mod+7 workspace number 7
bindsym $mod+8 workspace number 8
bindsym $mod+9 workspace number 9

bindsym $mod+KP_1 workspace number 1
bindsym $mod+KP_2 workspace number 2
bindsym $mod+KP_3 workspace number 3
bindsym $mod+KP_4 workspace number 4
bindsym $mod+KP_5 workspace number 5
bindsym $mod+KP_6 workspace number 6
bindsym $mod+KP_7 workspace number 7
bindsym $mod+KP_8 workspace number 8
bindsym $mod+KP_9 workspace number 9

# move focused container to workspace
bindsym $mod+Shift+KP_1 move container to workspace number 1
bindsym $mod+Shift+KP_2 move container to workspace number 2
bindsym $mod+Shift+KP_3 move container to workspace number 3
bindsym $mod+Shift+KP_4 move container to workspace number 4
bindsym $mod+Shift+KP_5 move container to workspace number 5
bindsym $mod+Shift+KP_6 move container to workspace number 6
bindsym $mod+Shift+KP_7 move container to workspace number 7
bindsym $mod+Shift+KP_8 move container to workspace number 8
bindsym $mod+Shift+KP_9 move container to workspace number 9

bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5
bindsym $mod+Shift+6 move container to workspace number 6
bindsym $mod+Shift+7 move container to workspace number 7
bindsym $mod+Shift+8 move container to workspace number 8
bindsym $mod+Shift+9 move container to workspace number 9

exec --no-startup-id i3-msg "workspace 1; layout tabbed"

bindsym $mod+n exec i3-input -F 'rename workspace to "%s"' -P 'New name for this workspace: '

# Start compton
exec --no-startup-id compton -b
