#!/usr/bin/env bash

# change dir to the script's containing dir
cd "$(dirname "$(realpath "$0")")";

# export all sourced vars
set -a
source ../paths
set +a

rm common/sway_config_env_vars
while IFS='=' read -r -d '' n v; do
    line=$(printf "set $%s '%s'" "$n" "$v" | tr '\n' ' ')
    echo $line >> common/sway_config_env_vars
    # echo $line
done < <(env -0)

list=(
common/sway_config_env_vars
common/0_settings_base.sh
common/1_colors.sh
common/2_workspaces.sh
common/3_bar.sh
common/4_bindings.sh
common/5_apps_cfgs_bindings.sh
common/6_startup.sh
)

rm config
for F in ${list[@]} ; do
  echo adding $F to config
  cat $F >> config
done

