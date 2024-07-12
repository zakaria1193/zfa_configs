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

# Rename workspace
bindsym $mod+n exec i3-input -F 'rename workspace to "%s"' -P 'New name for this workspace: '
