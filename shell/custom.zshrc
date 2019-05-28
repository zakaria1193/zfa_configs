#!/usr/bin/env bash

# change dir to the script's containing dir
cd "$(dirname "$(realpath "$0")")";

PATHS='../paths'

files_to_source=(
  $PATHS
  *.sh
)

function source_file
{
  local file=$1
  if [ -f $file ]; then
    source $file
  else
    echo "$file wasn't found (current_dir = $(pwd))"
  fi
}

function main()
{
  for F in ${files_to_source[@]} ; do
    source_file $F
  done
}

main $@

cd $HOME
