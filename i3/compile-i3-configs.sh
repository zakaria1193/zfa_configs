#!/usr/bin/env bash

# change dir to the script's containing dir
cd "$(dirname "$(realpath "$0")")";

# export all sourced vars
set -a
source ../paths
set +a

rm common/i3_config_env_vars
while IFS='=' read -r -d '' n v; do
    line=$(printf "set $%s '%s'" "$n" "$v" | tr '\n' ' ')
    echo $line >> common/i3_config_env_vars
    # echo $line
done < <(env -0)

work_list=(
common/i3_config_env_vars
common/common_i3_config.sh
work/work_specific_settings.sh
)

home_list=(
common/i3_config_env_vars
common/common_i3_config.sh
home/home_specific_settings.sh
)

device_name=$(cat /sys/devices/virtual/dmi/id/product_name)

# given host name choose config (fall back to a default config)
if [[ $device_name == 'HP Notebook' || $HOSTNAME == 'zfadli-OptiPlex-3060'  ]]; then
  echo -e "generating i3 config for home (device_name: $device_name)"
  list=${home_list[@]}
else
  echo -e "generating i3 config for work (device_name: $device_name)"
  list=${work_list[@]}
fi



rm config
for F in ${list[@]} ; do
  echo adding $F to config
  cat $F >> config
done

