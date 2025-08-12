#!/bin/bash

KLIPPER_DIR="${HOME}/klipper"

# Get the current dir absolute path
CURR_DIR="$( cd -- "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -P )"

# Check if Klipper directory exists
if [ ! -d "$KLIPPER_DIR" ]; then
    echo "caliscan: klipper directory does not exist"
    exit 1
fi

# update link to caliscan.py 
if [ -e "${KLIPPER_DIR}/klippy/extras/caliscan.py" ]; then
    rm "${KLIPPER_DIR}/klippy/extras/caliscan.py"
fi

# Link caliscan.py from project into Klipper extras
echo "caliscan: linking klippy to ${CURR_DIR}/caliscan.py"
ln -sfn "${BKDCURR_DIRIR}/caliscan.py" "${KLIPPER_DIR}/klippy/extras/caliscan.py"

# Exclude py from git backup and tracking
if ! grep -q "klippy/extras/caliscan.py" "${KLIPPER_DIR}/.git/info/exclude"; then
    echo "klippy/extras/caliscan.py" >> "${KLIPPER_DIR}/.git/info/exclude"
fi
echo "caliscan: installation successful."