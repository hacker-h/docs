#!/bin/bash
set -eu

# Settings
DEPENDENCIES_PATH="./.dependencies"
TMP_DIR="/tmp"
FIRMWARE_TYPE=${FIRMWARE_TYPE:-coordinator}
FIRMWARE_VERSION=${FIRMWARE_VERSION:-master}

# Enable the bootloader with a modified script
python ${DEPENDENCIES_PATH}/uartLog.py | tee ${TMP_DIR}/output.txt
DEVICE_NAME=$(cat ${TMP_DIR}/output.txt | grep -Eo '/dev/[a-zA-Z0-9]+')

# For Sonoff Zigbee 3.0 USB Dongle Plus (which uses CC2652P)
# Updated to the latest 20240710 firmware
if [ "$FIRMWARE_TYPE" == "coordinator" ]; then
    FIRMWARE_NAME="CC1352P2_CC2652P_launchpad_coordinator_20240710.zip"
elif [ "$FIRMWARE_TYPE" == "router" ]; then
    # If you need router firmware, you might need to adjust this name
    # based on what's available in the router directory
    FIRMWARE_NAME="CC1352P2_CC2652P_launchpad_router_20221102.zip"
else
    echo "Unknown firmware type: $FIRMWARE_TYPE"
    exit 1
fi

echo "Using firmware: $FIRMWARE_NAME"

# Cleanup
rm -f ${TMP_DIR}/firmware.zip
rm -f ${TMP_DIR}/*.hex

# Download firmware
wget -O ${TMP_DIR}/firmware.zip \
    https://github.com/Koenkk/Z-Stack-firmware/raw/${FIRMWARE_VERSION}/${FIRMWARE_TYPE}/Z-Stack_3.x.0/bin/${FIRMWARE_NAME}
unzip -o ${TMP_DIR}/firmware.zip -d ${TMP_DIR}/

# Flash the dongle with firmware
python ${DEPENDENCIES_PATH}/cc2538-bsl.py -p ${DEVICE_NAME} -evw ${TMP_DIR}/*.hex --bootloader-sonoff-usb

# Cleanup
rm ${TMP_DIR}/firmware.zip
rm -f ${TMP_DIR}/*.hex