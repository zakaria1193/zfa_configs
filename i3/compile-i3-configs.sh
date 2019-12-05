#!/usr/bin/env bash

# change dir to the script's containing dir
cd "$(dirname "$(realpath "$0")")";

# export all sourced vars
set -a
source ../paths
set +a

work_list=(
common/i3_config_env_vars.sh
common/base_i3_config.sh
common/workspace_i3_generic_bindings.sh
common/i3bar_config.sh
work/work_specific_settings.sh
common/common_default_apps_i3.sh
)

home_list=(
common/i3_config_env_vars.sh
common/base_i3_config.sh
common/workspace_i3_generic_bindings.sh
common/i3bar_config.sh
home/home_specific_settings.sh
common/common_default_apps_i3.sh
)

device_name=$(cat /sys/devices/virtual/dmi/id/product_name)

# given host name choose config (fall back to a default config)
if [[ $device_name == 'HP Notebook' ]]; then
  echo -e "generating i3 config for home (device_name: $device_name)"
  list=${home_list[@]}
else
  echo -e "generating i3 config for work (device_name: $device_name)"
  list=${work_list[@]}
fi

rm common/i3_config_env_vars
while IFS='=' read -r -d '' n v; do
    line=$(printf "set $%s '%s'" "$n" "$v" | tr '\n' ' ')
    echo $line >> common/i3_config_env_vars
    # echo $line
done < <(env -0)


rm config
for F in ${list[@]} ; do
  echo adding $F to config
  cat $F >> config
done

