#!/usr/bin/env bash

# change dir to the script's containing dir
cd "$(dirname "$(realpath "$0")")";

PATHS='../paths'

function source_file
{
  local file=$1
  if [ -f $file ]; then
    echo $file
    source $file
  else
    echo "$file wasn't found (current_dir = $(pwd))"
  fi
}

files_to_source=(
  $PATHS
  *.sh
)

function main()
{
  for F in ${files_to_source[@]} ; do
    source_file $F
  done
}

main $@
