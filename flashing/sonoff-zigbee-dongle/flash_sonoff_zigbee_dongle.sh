#!/bin/bash
set -eu

# Enable bootloader + flash firmware

# Enable the bootloader with a modified script
python uartLog.py | tee /tmp/output.txt
DEVICE_NAME=$(cat /tmp/output.txt | grep -Eo '/dev/[a-zA-Z0-9]+')

# Download firmware
wget https://github.com/Koenkk/Z-Stack-firmware/raw/master/coordinator/Z-Stack_3.x.0/bin/CC1352P2_CC2652P_launchpad_coordinator_20220219.zip -O /tmp/firmware.zip
ls /tmp/*.hex > /dev/null && rm /tmp/*.hex
unzip /tmp/firmware.zip -d /tmp/
rm /tmp/firmware.zip

# Flash the dongle with new firmware
python cc2538-bsl.py -p ${DEVICE_NAME} -evw /tmp/*.hex --bootloader-sonoff-usb
