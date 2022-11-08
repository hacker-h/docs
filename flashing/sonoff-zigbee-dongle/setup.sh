#!/bin/bash
set -eu

# Settings
DEPENDENCIES_PATH="./.dependencies"
VIRTUALENV_PATH="${HOME}/.venv/sonoff_zigbee_dongle"

# Setup virtualenv
virtualenv -p python3.9 ${VIRTUALENV_PATH}
source ${VIRTUALENV_PATH}/bin/activate

# Install dependencies
pip3 install --upgrade pyserial intelhex gevent

mkdir -p ${DEPENDENCIES_PATH}

# Download Bootloader Activation tool
VERSION="1.0"
CHECKSUM="d9af1116ff38cf32ee5c5f73a817a9bb3783e7cc74ba60d716811ddee5f2ff96"
until echo "${CHECKSUM} ${DEPENDENCIES_PATH}/uartLog.py" | sha256sum -c;
do
wget -O ${DEPENDENCIES_PATH}/uartLog.py \
    https://raw.githubusercontent.com/hacker-h/Sonoff_zigbee_3.0_USB_dongle_plus_bootloader_script/${VERSION}/uartLog.py;
done

# Download Flashing tool
VERSION="v1.0"
CHECKSUM="85b4377f65e502ca5117853c06462c0af3dc181bf103ba3fbe4074cb6f7ba6bf"
until echo "${CHECKSUM} ${DEPENDENCIES_PATH}/cc2538-bsl.py" | sha256sum -c;
do
wget -O ${DEPENDENCIES_PATH}/cc2538-bsl.py \
    https://raw.githubusercontent.com/hacker-h/cc2538-bsl/${VERSION}/cc2538-bsl.py;
done

