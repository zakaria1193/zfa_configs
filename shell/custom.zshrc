#!/usr/bin/env bash

# change dir to the script's containing dir
cd "$(dirname "$(realpath "$0")")";

# reset path variable
export PATH=''
source /etc/environment

function source_file
{
  local file=$1
  if [ -f $file ]; then
    # echo custom zshrc sourcing: $1
    source $file
  else
    echo "$file wasn't found (current_dir = $(pwd))"
  fi
}

PATHS='../paths'

PATHS=$(readlink -m $PATHS)

# export Paths for scripts that wanna go through the Paths file themselves
export PATHS="$PATHS"

# call the paths so my custom scripts files are in added into path (so can be called directly)
source_file $PATHS

# source other bash files for aliases and functions
files_to_source=(
  *_aliases.sh
  $WORK_SHELL/*_aliases.sh
  $WORK_SHELL/api_helpers.sh
)

for F in ${files_to_source[@]} ; do
  source_file $F
done

cd - > /dev/null
