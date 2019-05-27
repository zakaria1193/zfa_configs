#!/bin/bash

# REPOS
#####################################
#      scripts and aliases        #
#####################################
alias scripts_authorize_new="sudo chmod 777 "$MY_SCRIPTS"/*"
alias aliases_source="source $HOME/.bash_aliases"
alias c="clear && aliases_source"

alias make_path_arm="PATH=$PATH:$FIRMWARE_BITCLOUD/toolchain/arm-none-eabi/bin make"
alias make_preproc='CFLAGS=-E make'

alias t="task"
alias ta="task add"

alias wl="watch lsusb"
alias wallpaper="$MY_SCRIPTS/wallpaper.sh"
alias opacity="gconftool-2 --set /apps/gnome-terminal/profiles/Default/background_darkness --type=float" # then a float btw 0 and 1

alias af='find -iname'
function find_and_replace()
{
  from=$1
  to=$2
  git grep -l $from | xargs sed -i s/$from/$to/g
}

alias swap="sudo swapoff /dev/sda5 && sync && sleep 5 && sudo swapon /dev/sda5"

alias update="sudo apt-get update && sudo apt-get upgrade"

#db for clang autocomplete
alias db-firmware-bitcloud="cd $FIRMWARE_BITCLOUD && compiledb -n make UNSECURED=y > $FIRMWARE_BITCLOUD/compile_commands.json && cd -"
alias db-firmware="cd $FIRMWARE && compiledb -n make PFX=nlg > $FIRMWARE/compile_commands.json && cd -" # add path to easy clang settings
alias db='db-firmware-bitcloud && db-firmware'


# python
alias python='ipython3'
alias ipython3='ipython3'
alias python3='ipython3'

#####################################
#       	GIT STUFF		              #
#####################################
alias gmaster='git checkout master'

alias gupstream='git rev-parse --abbrev-ref --symbolic-full-name @{u}'
alias gcurrentbranch='git rev-parse --abbrev-ref HEAD'

function git_find_and_replace_in_branch()
{
  from="$1"
  to="$2"
  root_branch="$3"
  if [ -z $root_branch ]
  then
    root_branch='master'
  fi

  command="git grep -l $from | xargs -r sed -i s/$from/$to/g"

  git rebase -i --exec "$command" "$root_branch"
}


root='git merge-base master HEAD'

alias gs='git status'
alias gck='git checkout'
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' -13 --abbrev-commit" # shows 13 lines
alias gllong="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # show max lines
alias glverb="git log --stat --graph --date=local --pretty=format:'%C(yellow)%h%Cblue %ad%Cgreen %an %Cred%d%n%Creset%x09%s%n'"
alias glfind="git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -5 --grep"
alias grl="git reflog --format='%C(auto)%h %<|(20)%gd %C(blue)%cr%C(reset) %gs (%s)'"
alias gamend='git commit --amend --no-edit'
alias gamendmsg='git commit --amend'
alias gcom='git commit -m'
alias g-hard='git reset --hard'
alias g-hard^='git reset --hard HEAD^'
alias gfixup='git commit --fixup'
alias gap='git add -p'
alias gA='git add -A'
alias grp='git reset -p'
alias gr='git reset'
alias gr^='git reset HEAD^'
alias grp^='git reset -p HEAD^'
alias gcf='git clean -fd'
alias gcu='git checkout -- .' # clean unstaged

alias gpush="git push origin"
alias gpushf="gpush -f"
alias gpushskip="gskipci && gpush"
alias gsub='git submodule update --init'
alias gsubfix='git submodule deinit -f --all && gsub'
alias gpullm='gmaster && git pull --prune && gsub && git checkout -'
alias gpull='git pull --prune origin $(gcurrentbranch)' #pulls current branch
alias gf='git fetch --prune'

alias grebi='git rebase -i --keep-empty'
alias grebim='git rebase -i --keep-empty master && gsub'
alias grebm='git rebase --keep-empty master && gsub'
alias gautofixup-on-master='git-autofixup master && grebim'
alias gautofixup='git-autofixup'

alias gc='git rebase --continue'
alias gsk='git rebase --skip'
alias ga='git rebase --abort'

alias gst='git stash'
alias gstap='git stash apply'
alias gstsh='git stash show -v'

#       Chery picks         #
alias gch='git cherry-pick'
alias gchc='git cherry-pick --continue'
alias gcha='git cherry-pick --abort'

alias gsh='git show'

alias gd='git diff'
alias gds='git diff --staged'
#       Bitcloud - branches Specific      #
alias grelay='git checkout zfa/relay_driver && gsub'
alias gnlfs='git checkout zfa/drop-sync-stab && gsub'

alias gskipci='git commit --allow-empty -m "[skip ci]"'

grep_blame() {
    git grep -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | grep $1; done;
}

alias TODO='git grep -l TODO | xargs -n1 git blame -f -n -w | grep Zakaria | sed "s/.\{9\}//" | sed "s/(.*)[[:space:]]*//" | ag TODO'
alias TODO-ALL='git grep -l TODO | xargs -n1 git blame -f -n -w | sed "s/.\{9\}//" | sed "s/(.*)[[:space:]]*//" | ag TODO'
alias FIXME='git grep -l FIXME | xargs -n1 git blame -f -n -w | grep Zakaria | sed "s/.\{9\}//" | sed "s/(.*)[[:space:]]*//" | ag FIXME'
alias FIXME-ALL='git grep -l FIXME | xargs -n1 git blame -f -n -w | sed "s/.\{9\}//" | sed "s/(.*)[[:space:]]*//" | ag FIXME'

#####################################
#       FLASH/DEBUG                 #
#####################################
alias m='make_launcher'
# m NLx

alias f='flash_launcher'
# f NLx

#mf NLx #to make and flash nlx
alias gdb='gdb_launcher' #gdb NLX #gdb z3device

alias kj='killall -9 JLinkExe; killall -9 JLinkGDBServer'
alias jlink_19A='JLinkExe -if SWD -speed 1000 -device ATSAMR21E19A'
alias jlink_18A='JLinkExe -if SWD -speed 1000 -device ATSAMR21E18A'
alias j='kj; jlink_19A'

alias flash-bin="$FIRMWARE_BITCLOUD/support/scripts/flash-bin"
alias flash-product="$FIRMWARE_BITCLOUD/support/scripts/flash-product"

alias flasher="$EMBEDDED_TOOLS/Linux/flasher/flasher"
alias flasher-force="flasher -forceplugmode"
alias flasher-reboot="flasher -reboot"
alias make-dump-model='cd $FIRMWARE/cortex/LegrandGateway/model_parser && make clean && make'
alias dump-model='$FLASHER -dumpflashatoffset bin.bin 0x460000 0x40000 && $FIRMWARE/cortex/LegrandGateway/model_parser/nlg_model_parser bin.bin | less && rm bin.bin'
alias make-nlg-errors='make -j -i PFX=nlg NO_SPAM=y 2>&1 | ccze -A | ag '\.c' | grep "error" | grep -v "pragma"'
alias make-nlg-reflash='make -j PFX=nlg NO_SPAM=y reflash  2>&1| ccze -A  | grep -v -i "pragma"'

function log(){
  if [ -z $1 ]
    then
    echo "give tty (ACM0 or USB1 etc..)"
    ls /dev/ttyUSB*
    ls /dev/ttyACM*
    return
  fi
  minicom --device /dev/tty$1 -C $HOME/.minicom-logs.txt
}

alias netatmolog="$FIRMWARE_BITCLOUD/Applications/Netatmo/modules/netatmo-log/netatmo_log.py"
function log_usb(){
  if [ -z $1 ]; then
    ls /dev/ttyUSB*
    echo 'for st add -st after usb tty number'
    return
  fi

  if [[ -z $2 ]]; then
    br=115200
    echo "baudrate = 115200"
  else
    br=38400
    echo 'baudrate = 38400'
  fi

  echo "opening usb $1"
  clear
  rm $HOME/logs_USB$1
  netatmolog -s USB$1 -b $br -w $HOME/logs_USB$1
}
function log_acm(){
  if [ -z $1 ]; then
    ls /dev/ttyACM*
    return
  fi

  echo "opening acm $1"
  clear
  rm   rm $HOME/logs_ACM$1
   netatmolog -s ACM$1 -b 38400 -w $HOME/logs_ACM$1
}

#for factory tetts
function usb_iss(){

  if [ -z $1 ]; then
    ls /dev/ttyACM*
    return
  fi

  echo "opening acm $1 for usb_iss"
  $EMBEDDED_TOOLS/Linux/usb_iss/usb_iss "/dev/ttyACM${1}"
}

alias usb_iss_py="$PYTHON_EMBEDDED_TOOLS/bin/usb_iss/usb_iss_interface.py"

#zigbee
alias sniffer11="pkill wireshark; $PYTHON_EMBEDDED_TOOLS/lib/zigbee/python_zigbee_interface.py -c 11"
alias sniffer13="pkill wireshark; $PYTHON_EMBEDDED_TOOLS/lib/zigbee/python_zigbee_interface.py -c 13"


alias logcat='$ANDROID_TOOLS/coloredlogcat.py logcat'
# lergrand logs as V (verbose and all other as S (silent))
alias log_app="logcat 'LogInterceptor:V *:S'"

#####################################
#         generate  eeprom          #
#####################################
alias generate-release="$PYTHON_EMBEDDED_TOOLS/bin/release/generate_release.py" # -p NLX -v 42
alias generate-magellan-eeprom="$FIRMWARE_BITCLOUD/support/scripts/generate-magellan-eeprom.sh" # -p NLX -v 42
alias sftp='sftp -P 1021 fw@fpp.netatmo.net'

#flash mac and secret for ST
function flasher-ie-st()
{
  MAC_ADDR=$1
  SECRET=$2
  # if [ [-z $MAC_ADDR ] || [-z $SECRET ] ]
    # then
    # echo 'error: give mac adress and secret'
    # return
  # fi
  # flasher -set "00:04:74:14:02:3c" netcom.netatmo.net "420fa317aecaecb7ae6cbf63a1ea10d7" 0
  flasher -set "00:04:74:22:00:58" netcom.netatmo.net "0b5111fad2dea107423fe298869deead" 0
}
alias flasher-wifi="flasher -wifi -ap=kermen" #puts kermen wifi configuration in gateway
alias flasher-reset-wifi="flasher -del 7 -1 && flasher -del 72 -1 && flasher -del 85 -1"
alias flasher-inté="flasher -setserver nv2 netcomv2.inte.netatmo.net"
alias flasher-prod="flasher -setserver nv2 nv2-nlg.netatmo.net"

alias nlx_flasher="ipython3 -i $PYTHON_EMBEDDED_TOOLS/lib/testing/nlx_flasher.py"

alias checkcode="$PYTHON_EMBEDDED_TOOLS/common/coding_style_tools/git-hook/pre-commit-netatmo-c"

alias get_line="$FIRMWARE/toolchain/arm-2013.11/bin/arm-none-eabi-addr2line -e $FIRMWARE/cortex/LegrandGateway/app.elf"

##
## Dev Tools
##

function code-size(){
product=$1
cd $FIRMWARE_BITCLOUD/Applications/Netatmo/Magellan/${product}/Build/App/objs/Applications/Netatmo/Magellan/${product}/src/
if [ $# != 0 ]
  then
  echo great
  arm-none-eabi-size --format=berkeley *.o
fi

cd -
}



##############TRY ME OUT#####################
tips="

$which - showhs where's the binary for a command
$whereis - same but looks also in packages

$type - shows if command is an lias or builtin etc..

$eval evalutes string as a command
$exec ??
$command ??

$file shows type of a file like file /usr/bin/python3.4 says it's an elf 64 bit exec (which means it's coded in c?)

$ls -i - shows symbolic links

$shutdown now (-r to reboot, can give any x minutes) (better than halt powerOff reboot)

FIXME what is exec and command? difference?

tee takes the output from any command, and, while sending it to standard output, it also saves it to a file.
$ls -l | tee newfile
$tac (cat backwards)

$tail and head (only 10 last or first lines)
$tail -n 15 file for last 15 line
$tail -f file to follow any new lines added to file (useful for logs)

$touch -t 03201600 myfile (sets date to file)
$rm -i (interactive, use it when givin a pattern)
$PS1 is terminal prompt (you can wwrite to it)
$man $ info give information on commands
$help for built in shell commands

"





advanced_commands=" AWK SED GREP FIND

REGEX for pattern definition (to use with awk, sed, vim, find, grep, python..)
!= from WILDCARDS(globbing characters) (used in bash files search)
see cheatsheet

$AWK (for advanced data extraction)
The input file is read one line at a time, and, for each line, awk matches the given pattern in the given order and performs the requested action.
 The -F option allows you to specify a particular field separator character.
  For example, the /etc/passwd file uses ":" to separate the fields, so the -F: option is used with the /etc/passwd file.
  The command/action in awk needs to be surrounded with apostrophes (or single-quote)
awk '{ print $0 }' /etc/passwd  Print entire file
awk -F: '{ print $1 }' /etc/passwd  Print first field (column) of every line, separated by a space
awk -F: '{ print $1 $7 }' /etc/passwd Print first and seventh field of every line

$SED (like awk but for simple stuff, mostly search and replace in directory)
sed can filter text, as well as perform substitutions in data streams, working like a churn-mill.
$sed s/pattern/replace_string/ file  Substitute first string occurrence in a line
$sed s/pattern/replace_string/g file Substitute all string occurrences in a line (g for globally)
$sed 1,3s/pattern/replace_string/g file  Substitute all string occurrences btw lines 1 and 3
$sed -i s/pattern/replace_string/g file  Save changes for string substitution in the same file
-e options to pass multiple commands, can also pass script with -f

$GREP [options] PATTERN [PATH]
grep [pattern] <filename> Search for a pattern in a file and print all matching lines
example: grep [0-9] <filename> Print the lines that contain the numbers 0 through 9
-r for recursive in directories
-v for all lines that do NOT match pattern
-C n with a context of N

AG faster, but only limited regex (subset, no flag needed) //FIXME make sure of this


$FIND  WHERE -name PATTERN
$FIND  WHERE -iname PATTERN (case insensitive)
$FIND -name "*.swp" -exec rm {} ’;’ (delete all files that match pattern, The {} is a place holder that will be filled with all the file names that result from the find expression, and the preceding command will be run on each one individually.  you have to end the command with either ‘;’ (including the single-quotes) or "\;". Both forms are fine.)
When no arguments are given, find lists all files in the current directory and all of its subdirectories.
-ok option behaves the same as -exec, except that find will prompt you for permission before executing.
$FIND / -ctime 3 >>>> (finds all files in / changes 3 minutes ago)
$FIND / -size +10M -exec rm {} ’;’ >>> deletes files over 10M

$LOCATE PATTERN (takes globbing pattern if flag -b,  can use regex by --regex)
just lists database of all files (generated by (sudo) updatedb which can be called)
why -b ? see https://stackoverflow.com/questions/17262827/bash-locate-command-with-pattern

Wildcard  Result
?         Matches any single character
*         Matches any string of characters
[set]     Matches any character in the set of characters, for example [adf] will match any occurrence of a, d, or f
[!set]    Matches any character not in the set of characters

FILE TYPES:
- : regular file
d : directory
c : character device file
b : block device file
s : local socket file
p : named pipe
l : symbolic link
"

programming="
for opening binary files:
$hexdump -C x.bin (shows the strings in the binary too)
$stings (shows the strings only, can show lib library calls)
$objdump -d x.bin (disassembles the whole binary)
$objdump -x x.bin (shows the sections and other interesting info)
$nm     dumps the symbols
$readelf like objdump but better for elf file, can't read 
$nm reads symbols (FIXME but does it really?)
$strace shows all syscalls made by program
$ltrace shows all dynamic  libraries calls&&
$gdb
$r2 x.bin (radare2)( type aaa at first to analyse program), a lot of cool stuff like VV for visual disassemby mode (graph))
"
syscalls="



"
processes="
PROCESSES
$ ps (only assosiated to invoking terminal)
$ ps -elf to show all threads (not only processes)
$ pstree (shows ofr processes tree)
$ w or top or htop (shows load on cpu of each process)
$ kill -SIGKILL <pid>
$ kill -9 <pid>
CTRL-Z to suspend a ps (in foreground)
$ jobs shows process in backgroundof a terminal

Process Type  Description Example
Interactive     Processes Need to be started by a user, either at a command line or through a graphical interface such as an icon or a menu selection.                                                  bash, firefox, top
Batch           Processes Automatic processes which are scheduled from and then disconnected from the terminal. These tasks are queued and work on a FIFO (First In, First Out) basis.                  updatedb
Daemons         Server processes that run continuously. Many are launched during system startup and then wait for a user or system request indicating that their service is required.                   httpd, xinetd, sshd
threads         Lightweight processes. These are tasks that run under the umbrella of a main process, sharing memory and other resources, but are scheduled and run by the system on an individual basis. An individual thread can end without terminating the whole process and a process can create new threads at any time. Many non-trivial programs are multi-threaded.      firefox, gnome-terminal-server
Kernel Threads  Kernel tasks that users neither start nor terminate and have little control over. These may perform actions like moving a thread from one CPU to another, or making sure input/output operations to disk are completed.         kthreadd, migration, ksoftirqd

$EXEC
To understand exec you need to first understand fork. I am trying to keep it short.

When you come to a fork in the road you generally have two options. Linux programs reach this fork in the road when they hit a fork() system call.

Normal programs are system commands that exist in a compiled form on your system. When such a program is executed, a new process is created. This child process has the same
 environment as its parent, only the process ID number is different. This procedure is called forking.

Forking provides a way for an existing process to start a new one. However, there may be situations where a child process is not the part of the same program as parent process.
 In this case exec is used. exec will replace the contents of the currently running process with the information from a program binary.
After the forking process, the address space of the child process is overwritten with the new process data. This is done through an exec call to the system.
"

web_networking="

$HTTP
the headersg

$TCP

The six basic TCP flags
    The original TCP packet format has six flags. Two more optional flags have since been standardized, but they are much less important to the basic functioning of TCP. For each packet, tcpdump will show you which flags are set on that packet.
    SYN (synchronize) [S] — This packet is opening a new TCP session and contains a new initial sequence number.
    FIN (finish)      [F] — This packet is used to close a TCP session normally. The sender is saying that they are finished sending, but they can still receive data from the other endpoint.
    PSH (push)        [P] — This does TWO THINGS: The sending application informs TCP that data should be sent immediately. the PSH flag in the TCP header informs the receiving host that the data should be pushed up to the receiving application immediately. This packet is the end of a chunk of application data, such as an HTTP request.so
    RST (reset)       [R] — This packet is a TCP error message; the sender has a problem and wants to reset (abandon) the session.
    ACK (acknowledge) [.] — This packet acknowledges that its sender has received data from the other endpoint. Almost every packet except the first SYN will have the ACK flag set.
    URG (urgent)      [U] — This packet contains data that needs to be delivered to the application out-of-order. Not used in HTTP or most other current applications. The urgent pointer field is to be checked by receiver when the flag is set to know how much is urgent.
Three-way handshake
    The first packet sent to initiate a TCP session always has the SYN flag set. This initial SYN packet is what a client sends to a server to start opening a TCP connection. This is the first packet you see in the sample tcpdump data, with Flags [S]. This packet also contains a new, randomized sequence number (seq in tcpdump output).
    If the server accepts the connection, it sends a packet back that has the SYN and ACK flags, and acknowledges the initial SYN. This is the second packet in the sample data, with Flags [S.]. This contains a different initial sequence number.
    (If the server doesn't want to accept the connection, it may not send anything at all. Or it may send a packet with the RST flag.)
    Finally, the client acknowledges receiving the SYN|ACK packet by sending an ACK packet of its own.
    This exchange of three packets is usually called the TCP three-way handshake. In addition to sequence numbers, the two endpoints also exchange other information used to set up the connection.
Four-way teardown
    When either endpoint is done sending data into the connection, it can send a FIN packet to indicate that it is finished. The other endpoint will send an ACK to indicate that it has received the FIN.
    In the example HTTP data, the client sends its FIN first, as soon as it is done sending the HTTP request. This is the first packet containing Flags [F.].
    Eventually the other endpoint will be done sending as well, and will send a FIN of its own. Then the first endpoint will send an ACK.

In between
    In a long-running connection, there will be many packets exchanged back and forth. Some of them will contain application data; others may be only acknowledgments with no data (length 0). However, all TCP packets in a connection except the initial SYN will contain an acknowledgment of all the data that the sender has received so far. Therefore, they will all have the ACK flag set. (This is why tcpdump depicts the ACK flag with just a dot: it's really common.)

ICMP and DNS don't have TCP flags
    If you look at tcpdump data for pings or basic DNS lookups, you will not see flags. This is because ping uses ICMP, and basic DNS lookups use $UDP. These protocols do not have TCP flags or sequence numbers.

my notes on TCP
  serverless protocol (no client and server)
  each side uses sequences numbers on packet (to maintain order and acking)
  all packets have an ack.
  no pure ack packets (acks are embedded into data sending from the acking/nacking side), 
    if the client or server has nothing to send it will send stuff with len=0 while incrementing its sequence number
  example :
    client will send packet 3 THEN server will send pcket 5001 with ACK 4 (received all up to 4 not included and sending my packet 5001)
    client will then ack 5002 when sendting its packet 4 etc..

$netcat is a TCP tool : (sends the exact strings you give it)
  client send HTTP request with netcat : $echo 'HEAD / HTTP/1?1\r\nHost www.google.com\r\n\r\n' | $nc www.google.com 80
  plain TCP server listen on port 3333 : $nc -l 3333 (listen on socket 3333, you can connect to it with 'nc  localhost 33333')
    connection is then full duplexed (you can write on server side and it appers on client side)
  highest port number 65535
  1-1023 reserved ports (can only be listened to with root privileges unless someone is already listening on it)

  $tcpdump -n host 8.8.8.8 can show the ICMP ping packets (the protocol that implements ping at top of layer 3 since it uses IP)
  $tcpdump -n port 53 : shows the DNS packets (port 53 is used by DNS)
  $tcpdump -n port 80 : shows the HTTP packets (port 53 is used by DNS)

  Connection :




$DNS
$nslookup or $host or $dig to do a dns lookup, $dig to get more details on how the ds query went.
there's different types of DNS records (CNAME = canocal name = alias (www.machin.com); 1 = IP4; AAAA = ipv6; NS = DNS name server)
an A record for www.googl.come is found in the NS for google.com which is found in the NS server of ".com"
first DNS server to receive query is the closest caching DNS server (so we the request never needs to go all the way to the NS server of the domain.. 
BUT DNS entries have TimeToLive so they expire in case we need to change them.)
the "www" in host names is not always necessary because hostnames dedicated to webtraffic www.example.com is set only as a CNAME to example.com.

$IP/$SUBNETTING
IP adresses are 32 bits, with 255.255.255.0 mask, you have 8 bits for host adressing 24bits for network adress it will be written as /24
only two machines on same sub network can talk directly (IP layer checks if target IP * subnet mask matches own subnet)
if not on same subnet, message is sent to default gateway, then default gateway etc.. until it goes to ISP routers that know where the routers actually are.
private IP adresses are not accesbile on the net cause not unique. (NAT is mandatory for outgoing comunnication andport forwarding to have a server always accessible from outside)
private adresses netbloccks are 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16
$ip addr show or $ifconfig to see the network interfaces

$traceroute hostname; $traceroute ip_adress; $mtr hostname
borh show the the routes traffic might take
hostnames of some of the hops have nearby airpots codes in them.
it uses the fact that routers sends back ICMP error messages when TTL of a massage exprires, so traceroute sends packets with TTL=0, TTL=1 ..etc and sees which routes reported that they expired until it's the destination host



$ping gives RTT (round trip time)
$latency is limited by number of hos and speed of light
$bandiwith (bits.s) / $latency = $amount of data in transit (in bits)


The most common configuration for a firewall is to drop any incoming traffic except traffic to (host, port) pairs that are supposed to be receiving connections from the Internet.
This lets the network administrator be sure that other machines on the network — like backend databases or administrative systems — aren’t going to get direct ttacks from outside.


$ethtool <interface>:
shows the capabilities of our networl hardware
ethtool -S eth0: gives stat on hardware level for eth0
ethtool -s eth0 speed 1000 duplex full: sets the speed and duplex  

$arp:
 (runs in background to resolve ip adresses)  
shows all mac adresses of recent devices in network i talked to.
arp -n: no nicknames

$wget:
just downlads the webpage if given http:// ip adress of a web server.

$netstat -s: 
option -n no nicknames.
network status information and satistics
$netstat -t -n shows the current tcp connections
$netstat -t -n -l shows only listening ones
if 0.0.0.0:someport means anyone can speak to my listening port
if 127.0.0.1: means only locally listening, only me can talk to me

$less /etc/services: shows the ports of commons applications
$less /etc/protocols: shows the protocol numbers
"












#########################
# GTW PDS TOOLS


function save_pds_gtw()
{
pds=$1

if [ -z "$1" ]
  then
    pds="$HOME/.saved_pds.bin"
  fi
 $FIRMWARE_BITCLOUD/support/scripts/flash-bin -t ATSAMR21E18 -b "$pds":0x2300:0x4000
}

function load_pds_gtw()
{
  pds=$1
  if [ -z "$1" ]
  then
    pds="$HOME/.saved_pds.bin"
  fi

 $FIRMWARE_BITCLOUD/support/scripts/flash-bin -t ATSAMR21E18 -b "$pds":0x2300
}

function get_bin_and_elf()
{
  if [ -z "$1" ]
  then
    echo "give target dir+prefix ex: ~/bug_muller/before"
    return
  fi

  if [ -z "$2" ]
  then
    echo "give target dir+prefix ex: ~/bug_muller/before "
    return
  fi
  NLX=$1
  target=$2
  cp "$FIRMWARE_BITCLOUD"/"$NLX_PATH_IN_FIRMWARE"/"$NLX"/"$NLX".elf  "${target}_$NLX.elf"
  cp "$FIRMWARE_BITCLOUD"/"$NLX_PATH_IN_FIRMWARE"/"$NLX"/B"$NLX".bin "${target}_B$NLX.bin"
  ls ${target}* -l
}




########################
# Release tester tools

MAGELLAN_TESTER="~/repos/core/python-emb-tools/bin/testing/magellan_tester.py"

alias magellan_tester="ipython3 $MAGELLAN_TESTER"
alias magellan_tester_pdb="ipython3 -m pdb $MAGELLAN_TESTER"

###################
# push binary to legrand files
function push_to_legrand
{
  PRODUCT=$1
  VERSION=$2

  cd $FIRMWARE_BINARY/Releases/Validation/$PRODUCT
  cp $MAGELLAN_RELEASES/$PRODUCT/${PRODUCT}_${VERSION}.zip .
}

###################
# source curl helpers
source $MY_SCRIPTS/shell/curl_helpers.sh