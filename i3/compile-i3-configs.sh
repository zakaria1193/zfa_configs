#!/usr/bin/env bash

# change dir to the script's containing dir
cd "$(dirname "$(realpath "$0")")";

# export all sourced vars
set -a
source  /home/zfadli/my_scripts/paths
set +a

work_list=(
common/base_i3_config
common/workspace_i3_generic_bindings
common/i3bar_config
home/home_specific_settings
common/common_default_apps_i3
)

home_list=(
common/base_i3_config
common/workspace_i3_generic_bindings
common/i3bar_config
work/work_specific_settings
common/common_default_apps_i3
)

# given host name choose config (fall back to a default config)
if [[ $HOST == 'zfadli-HP-Notebook' ]]; then
  echo 'generating i3 config for home'
  list=${home_list[@]}
else
  echo 'generating i3 config for work'
  list=${work_list[@]}
fi

rm generated_i3config.i3_config

echo $LOCK_SCRIPT

for F in ${list[@]} ; do
envsubst < $F >> generated_i3config.i3_config
done

