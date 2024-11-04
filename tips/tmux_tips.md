# TMUX

Start session
> tmux

- Named session
> tmux new -s gdb_sess
CTRL-B ? -> helP

- Detach from session
CTRL-B d

- Close session:
CTRL-D

- list sessions
> tmux ls 

- attach to session
> tmuch attach-session -t <id or name>

- Attach to last session:
> tmux a
> tmux attach

CTRL-B w -> Sow all sessions with all their windows
CTRL-B ( -> Next session
CTRL-B ) -> Previous session

CTRL-B ? -> help

Windows:

CTRL-B , -> Rename current window
CTRL-B & -> Close window
CTRL-B p -> Pervious Window
CTRL-B n -> Next Window
CTRL-B l -> Next Window


1 window can contain multiple panes

- Pane creation / modification
CTRL-B % -> New Pane on the right
CTRL-B " -> New Pane on the bottom
CTRL-B { -> Move pane right
CTRL-B } -> Move pane left

CTRL-B Arrows -> Move between panes
CTRL-B ; -> Last active pane
CTRL-B x -> Close current pane
CTRL-B z -> Zoom on pane
