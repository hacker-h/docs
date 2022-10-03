#!/bin/bash
set -eu

# Setup virtualenv
virtualenv -p python3.9 ~/.venv/sonoff_zigbee_dongle
source ~/.venv/sonoff_zigbee_dongle/bin/activate

# Install dependencies
pip3 install --upgrade pyserial intelhex gevent

# Download Bootloader Activation tool
VERSION="1.0"
CHECKSUM="d9af1116ff38cf32ee5c5f73a817a9bb3783e7cc74ba60d716811ddee5f2ff96"
until echo "${CHECKSUM} uartLog.py" | sha256sum -c;
do
wget -O uartLog.py \
    https://raw.githubusercontent.com/hacker-h/Sonoff_zigbee_3.0_USB_dongle_plus_bootloader_script/1.0/uartLog.py;
done

# Download Flashing tool
VERSION="v1.0"
CHECKSUM="85b4377f65e502ca5117853c06462c0af3dc181bf103ba3fbe4074cb6f7ba6bf"
until echo "${CHECKSUM} cc2538-bsl.py" | sha256sum -c;
do
wget -O cc2538-bsl.py \
    https://raw.githubusercontent.com/hacker-h/cc2538-bsl/v1.0/cc2538-bsl.py;
done
