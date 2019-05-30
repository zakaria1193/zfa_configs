#!/usr/bin/env bash

# find the current script's containing dir
SCRIPT_DIR="$(dirname "$(realpath "$0")")";

function source_file
{
  local file=$1
  if [ -f $file ]; then
    # echo custom zshrc sourcing: $1
    source $file
  else
    echo "$file wasn't found (SCRIPT_DIR = $(SCRIPT_DIR))"
  fi
}

# path variable operations
# ">> PATH variable"
export PATH=''
if [ -s /etc/environment ]; then
    # get the default path from system
    source /etc/environment
else
    # case for raspbian, use generic path
    PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games'
fi

# "  resetting PATH to /etc/environment"

PATHS_FILE="${SCRIPT_DIR}/../paths"
# PATHS_FILE=$(readlink -m $PATHS_FILE)
# ">> PATHS_FILE $PATHS_FILE"
# export Paths for scripts that wanna go through the PATHS_FILE themselves
# "  PATHS file location exported as PATHS = $PATHS_FILE"
export PATHS="$PATHS_FILE"
# "  sourcing PATHS_FILE file to fill and export custom env var and fill PATH variable"
source_file $PATHS_FILE

# "TIP: run paths to see the PATH variable"

# source other bash files for aliases and functions
files_to_source=(
  $SCRIPT_DIR/system_aliases.sh
  $SCRIPT_DIR/git_aliases.sh
  $SCRIPT_DIR/fzf_aliases.sh
  $SCRIPT_DIR/fzf_aliases_adrien.sh
  $SCRIPT_DIR/remote_aliases.sh
  $WORK_SHELL/*_aliases.sh
  $ZFA_WORK_TOOLS/api/api_helpers.sh
)
for F in ${files_to_source[@]} ; do
  source_file $F
done
