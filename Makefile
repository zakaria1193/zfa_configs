# need to use bash for 'source'
SHELL := /bin/bash

$(X_reconfig) : $(X)_cfg_files | $(X_install)
    source installers.sh && eval "pull_$(X)_config"

$(X_install) : $(X)_install_files
    source installers.sh && eval "install_$(X)"
