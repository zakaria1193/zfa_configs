IP_DESK_LOCAL="192.168.0.10"
MAC_DESK="54:bf:64:99:d3:ee"
IP_PI_LOCAL="192.168.0.11"
IP_PUBLIC_HOME="ip.zakariafadli.com"

alias ssh_desk_local="ssh -l zfadli $IP_DESK_LOCAL"
alias ssh_desk_rem="ssh -l zfadli -p 2222 $IP_PUBLIC_HOME"
alias wake_desk_local="wakeonlan $MAC_DESK"
alias wake_desk_rem="wakeonlan -i $IP_PUBLIC_HOME $MAC_DESK"

