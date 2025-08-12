#!/bin/bash

KLIPPER_DIR="${HOME}/klipper"

# Check if Klipper directory exists
if [ ! -d "$KLIPPER_DIR" ]; then
    echo "caliscan: klipper directory does not exist"
    exit 1
fi

# update link to caliscan.py 
echo "caliscan: linking klippy to caliscan.py"
if [ -e "${KLIPPER_DIR}/klippy/extras/caliscan.py" ]; then
    rm "${KLIPPER_DIR}/klippy/extras/caliscan.py"
fi

# create symlink
ln -sf "caliscan.py" "${KLIPPER_DIR}/klippy/extras/caliscan.py"

# Exclude py from git backup and tracking
if ! grep -q "klippy/extras/caliscan.py" "${KLIPPER_DIR}/.git/info/exclude"; then
    echo "klippy/extras/caliscan.py" >> "${KLIPPER_DIR}/.git/info/exclude"
fi
echo "caliscan: installation successful."