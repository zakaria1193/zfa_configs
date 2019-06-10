#!/usr/bin/env bash

# change dir to the script's containing dir
cd "$(dirname "$(realpath "$0")")";

# export all sourced vars
set -a
source ../paths
set +a

work_list=(
common/i3_config_env_vars
common/base_i3_config
common/workspace_i3_generic_bindings
common/i3bar_config
work/work_specific_settings
common/common_default_apps_i3
)

home_list=(
common/i3_config_env_vars
common/base_i3_config
common/workspace_i3_generic_bindings
common/i3bar_config
home/home_specific_settings
common/common_default_apps_i3
)

# given host name choose config (fall back to a default config)
if [[ $HOST == 'zfadli-HP-Notebook' ]]; then
  echo -e "generating i3 config for home (host: $HOST)"
  list=${home_list[@]}
else
  echo -e "generating i3 config for work (host: $HOST)"
  list=${work_list[@]}
fi

rm common/i3_config_env_vars
while IFS='=' read -r -d '' n v; do
    line=$(printf "set $%s '%s'" "$n" "$v" | tr '\n' ' ')
    echo $line >> common/i3_config_env_vars
done < <(env -0)


rm config
for F in ${list[@]} ; do
  echo adding $F to config
  cat $F >> config
done

