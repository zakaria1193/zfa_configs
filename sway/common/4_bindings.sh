
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
# restart sway inplace (preserves your layout/session, can be used to upgrade sway) (might take two)
bindsym $mod+Shift+r exec $COMPILE_SWAY_CONFIG_SCRIPT; restart

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

# Rename workspace
bindsym $mod+n exec sway-input -F 'rename workspace to "%s"' -P 'New name for this workspace: '

############################################
# Screen Outputs
############################################

# Handle multiple outputs
bindsym $mod+m focus output left
bindsym $mod+shift+m move workspace to output left

############################################
### Scratchpad
############################################
# Make the currently focused window a scratchpad
bindsym $mod+shift+p move scratchpad

# Show the first scratchpad window
bindsym $mod+p scratchpad show
############################################

# Lock screen
bindsym $mod+l exec $LOCK_SCRIPT

# Set monitor to laptop layout on ctrl + j
bindsym $mod+j exec autorandr laptop

# Logout sway (logs you out of your X session)
bindsym $mod+Shift+l exec "sway-nagbar -t warning -m 'Logout?' -b 'Yes' 'sway-msg exit'"

############################################
### Media keys
############################################
# Brightness
bindsym XF86MonBrightnessUp exec light -A 20
bindsym XF86MonBrightnessDown exec light -U 20

# Media player controls
bindsym XF86AudioPlay  exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext  exec playerctl next
bindsym XF86AudioPrev  exec playerctl previous

# Volume
bindsym XF86AudioRaiseVolume exec amixer -q set Master 5%+
bindsym XF86AudioLowerVolume exec amixer -q set Master 5%-
bindsym XF86AudioMute exec amixer -q set Master toggle

# Caps lock and num lock to status bar
bindsym --release Caps_Lock exec pkill -SIGRTMIN+11 i3blocks
bindsym --release Num_Lock  exec pkill -SIGRTMIN+11 i3blocks
############################################
