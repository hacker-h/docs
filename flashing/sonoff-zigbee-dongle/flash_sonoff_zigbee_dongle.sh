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

FIRMWARE_NAME=`curl -s \
    https://github.com/Koenkk/Z-Stack-firmware/tree/${FIRMWARE_VERSION}/${FIRMWARE_TYPE}/Z-Stack_3.x.0/bin |\
    grep CC2652P | grep launchpad | grep ${FIRMWARE_TYPE} | grep -Eo "[A-Za-z0-9_]+\.zip" | sort -u`
echo $FIRMWARE_NAME

# Cleanup
rm -f ${TMP_DIR}/firmware.zip
rm -f ${TMP_DIR}/*.hex

# Download firmware
wget -O ${TMP_DIR}/firmware.zip \
    https://github.com/Koenkk/Z-Stack-firmware/raw/${FIRMWARE_VERSION}/${FIRMWARE_TYPE}/Z-Stack_3.x.0/bin/${FIRMWARE_NAME}
unzip ${TMP_DIR}/firmware.zip -d ${TMP_DIR}/

# Flash the dongle with firmware
python ${DEPENDENCIES_PATH}/cc2538-bsl.py -p ${DEVICE_NAME} -evw ${TMP_DIR}/*.hex --bootloader-sonoff-usb

# Cleanup
rm ${TMP_DIR}/firmware.zip
