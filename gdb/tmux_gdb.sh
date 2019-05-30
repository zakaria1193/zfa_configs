#!/bin/bash

# FIXME this script is not working

# Session Name
session="GDB"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)
if [ "$SESSIONEXISTS" = "" ]
then
# Start New Session with our name
tmux new-session -d -s $session

# Name first Window
tmux rename-window -t 0 'SERVER'

tmux send-keys -t 'SERVER' 'gdb_server' C-m

# setup Writing window
tmux new-window -t $SESSION:1 -n 'CLIENT'
tmux send-keys -t 'CLIENT' 'gdb ' C-t
fi

# Attach Session, on the Main window
tmux attach-session -t $SESSION:1
