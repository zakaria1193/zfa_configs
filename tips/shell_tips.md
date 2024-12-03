# Shell Tips

## Basic Commands

- `which` - shows where the binary for a command is located
- `whereis` - similar to `which` but also looks in packages
- `type` - shows if a command is an alias, builtin, etc.
- `eval` - evaluates a string as a command
- `command` - runs the specified command, ignoring shell functions and aliases
- `file` - shows the type of a file (e.g., `file /usr/bin/python3.4` says it's an ELF 64-bit executable)
- `ls -i` - shows inode numbers
- `shutdown now` - shuts down the system immediately (`-r` to reboot, can specify a delay)
- `tee` - takes the output from a command and saves it to a file while also sending it to standard output (e.g., `ls -l | tee newfile`)
- `tac` - concatenates and prints files in reverse
- `touch -t 03201600 myfile` - sets the date of a file
- `rm -i` - interactive removal, useful when using patterns
- `PS1` - sets the terminal prompt
- `man` and `info` - provide information on commands
- `help` - provides information on built-in shell commands

## Advanced Commands

### AWK, SED, GREP, FIND

- `AWK` - for advanced data extraction
  - `awk '{ print $0 }' /etc/passwd` - print entire file
  - `awk -F: '{ print $1 }' /etc/passwd` - print first field of every line
  - `awk -F: '{ print $1 $7 }' /etc/passwd` - print first and seventh fields of every line

- `SED` - for simple text manipulation, mostly search and replace
  - `sed s/pattern/replace_string/ file` - substitute first occurrence of pattern in a line
  - `sed s/pattern/replace_string/g file` - substitute all occurrences of pattern in a line
  - `sed 1,3s/pattern/replace_string/g file` - substitute all occurrences of pattern between lines 1 and 3
  - `sed -i s/pattern/replace_string/g file` - save changes for string substitution in the same file

- `GREP` - for searching text using patterns
  - `grep [pattern] <filename>` - search for a pattern in a file and print all matching lines
  - `grep [0-9] <filename>` - print lines that contain numbers 0 through 9
  - `grep -r [pattern] [path]` - recursive search in directories
  - `grep -v [pattern] [path]` - print lines that do NOT match the pattern
  - `grep -C n [pattern] [path]` - print lines with a context of n lines
  # TODO add fzf & rg

- `FIND` - for searching files and directories
  - `find [where] -name [pattern]` - search for files matching the pattern
  - `find [where] -iname [pattern]` - case-insensitive search
  - `find [where] -name "*.swp" -exec rm {} \;` - delete all files matching the pattern
  - `find / -ctime 3` - find all files changed 3 minutes ago
  - `find / -size +10M -exec rm {} \;` - delete files larger than 10M

  # TODO add fd

- `LOCATE` - for finding files using a database
  - `locate [pattern]` - search for files matching the pattern
  - `locate -b [pattern]` - search using globbing pattern
  - `locate --regex [pattern]` - search using regex

### File Types

- `-` : regular file
- `d` : directory
- `c` : character device file
- `b` : block device file
- `s` : local socket file
- `p` : named pipe
- `l` : symbolic link

## Programming

### Opening Binary Files

- `hexdump -C x.bin` - shows the strings in the binary
- `strings x.bin` - shows the strings only, can show library calls
- `objdump -d x.bin` - disassembles the whole binary
- `objdump -x x.bin` - shows the sections and other interesting info
- `nm x.bin` - dumps the symbols
- `readelf -a x.bin` - like objdump but better for ELF files
- `strace x.bin` - shows all syscalls made by the program
- `ltrace x.bin` - shows all dynamic library calls
- `r2 x.bin` - radare2 (type `aaa` at first to analyze the program, a lot of cool stuff like `VV` for visual disassembly mode)

## Processes

### Managing Processes

- `ps` - shows processes associated with the invoking terminal
- `ps -elf` - shows all threads (not only processes)
- `pstree` - shows the process tree
- `w` or `top` or `htop` - shows load on CPU of each process
- `kill -SIGKILL <pid>` - forcefully kill a process
- `kill -9 <pid>` - forcefully kill a process
- `CTRL-Z` - suspend a process (in foreground)
- `jobs` - shows processes in the background of a terminal

### Process Types

- Interactive Processes - need to be started by a user (e.g., `bash`, `firefox`, `top`) Processes Need to be started by a user, either at a command line or through a graphical interface such as an icon or a menu selection
- Batch Processes - automatic processes scheduled and disconnected from the terminal (e.g., `updatedb`) These tasks are queued and work on a FIFO (First In, First Out) basis.
- Daemons - server processes that run continuously (e.g., `httpd`, `xinetd`, `sshd`)
- Threads - lightweight processes that share memory and resources. These are tasks that run under the umbrella of a main process, sharing memory and other resources, but are scheduled and run by the system on an individual basis. An individual thread can end without terminating the whole process and a process can create new threads at any time. Many non-trivial programs are multi-threaded. Many are launched during system startup and then wait for a user or system request indicating that their service is required.
- Kernel Threads - kernel tasks that users have little control over (e.g., `kthreadd`, `migration`, `ksoftirqd`)  These may perform actions like moving a thread from one CPU to another, or making sure input/output operations to disk are completed.

### Fork and Exec

- `fork` - creates a new process (child process) with the same environment as the parent process
- `exec` - replaces the contents of the currently running process with the information from a program binary

To understand exec you need to first understand fork. I am trying to keep it short.

When you come to a fork in the road you generally have two options. Linux programs reach this fork in the road when they hit a fork() system call.
Normal programs are system commands that exist in a compiled form on your system. When such a program is executed, a new process is created. This child process has the same environment as its parent, only the process ID number is different. This procedure is called forking.
Forking provides a way for an existing process to start a new one. However, there may be situations where a child process is not the part of the same program as parent process.
In this case exec is used. exec will replace the contents of the currently running process with the information from a program binary. After the forking process, the address space of the child process is overwritten with the new process data. This is done through an exec call to the system.

## Web Networking

### HTTP

- `wget` - downloads a webpage (e.g., `wget http://example.com`)

### TCP

- `netcat` - TCP tool
  - `echo 'HEAD / HTTP/1.1\r\nHost: www.google.com\r\n\r\n' | nc www.google.com 80` - send HTTP request with netcat
  - `nc -l 3333` - plain TCP server listening on port 3333
  - `nc localhost 3333` - connect to the TCP server on port 3333

- `tcpdump` - network packet analyzer
  - `tcpdump -n host 8.8.8.8` - show ICMP ping packets
  - `tcpdump -n port 53` - show DNS packets
  - `tcpdump -n port 80` - show HTTP packets

### DNS

- `nslookup` or `host` or `dig` - perform a DNS lookup
- `dig` - provides more details on how the DNS query was resolved

### IP/Subnetting

- `ip addr show` or `ifconfig` - show network interfaces
- `traceroute hostname` or `traceroute ip_address` or `mtr hostname` - show the routes traffic might take
- `ping` - gives round trip time (RTT)
- `ethtool <interface>` - shows the capabilities of the network hardware
- `arp` - shows MAC addresses of recent devices in the network
- `netstat -s` - network status information and statistics
- `netstat -t -n` - shows current TCP connections
- `netstat -t -n -l` - shows only listening TCP connections

### Firewall

- Common configuration: drop any incoming traffic except traffic to (host, port) pairs that are supposed to be receiving connections from the Internet

