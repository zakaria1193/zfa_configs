IP_LAPTOP_LOCAL="192.168.1.62"
IP_RASPBERRY_LOCAL="192.168.1.55"
IP_PUBLIC_HOME="176.142.84.105"

alias ssh_laptop_rem="ssh -l zfadli proxy50.rt3.io -p 33587"
alias     ssh_pi_rem="ssh -l pi     proxy51.rt3.io -p 38390"
alias    remotes_rem="sensible-browser https://app.remote.it/\#"

alias ssh_laptop_local="ssh -l zfadli $IP_LAPTOP_LOCAL"
alias ssh_pi_local="ssh -l zfadli $IP_RASPBERRY_LOCAL"
alias ssh_home_pi="ssh -l pi $IP_PUBLIC_HOME"