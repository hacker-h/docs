# Sonoff Zigbee Dongle Flashing Z-Stack 3.X.0

# Setup virtualenv
Setup a python3 environment (e.g. with [virtualenv](https://virtualenv.pypa.io/en/stable/)) and source it.:
```
virtualenv -p python3.9 ~/.venv/zigbee_sonoff_dongle
source ~/.venv/zigbee_sonoff_dongle/bin/activate
# install dependencies
pip3 install pyserial intelhex gevent
```

# Enable bootloader + flash firmware
```
# Enable the bootloader with a slightly modified script for Sonoff Zigbee Dongle 3.0
python uartLog.py | tee /tmp/output.txt
DEVICE_NAME=$(cat /tmp/output.txt | grep -Eo '/dev/[a-zA-Z0-9]+')

# Download firmware
wget https://github.com/Koenkk/Z-Stack-firmware/raw/master/coordinator/Z-Stack_3.x.0/bin/CC1352P2_CC2652P_launchpad_coordinator_20220219.zip -O /tmp/firmware.zip
ls /tmp/*.hex > /dev/null && rm /tmp/*.hex
unzip /tmp/firmware.zip -d /tmp/
rm /tmp/firmware.zip

# Flash the dongle with new firmware
python cc2538-bsl.py -p ${DEVICE_NAME} -evw /tmp/*.hex --bootloader-sonoff-usb
```

# Thanks to

Bootloader Activation Script:

https://github.com/Nerdiyde/Sonoff_zigbee_3.0_USB_dongle_plus_bootloader_script

Flashing Tool:

https://github.com/JelmerT/cc2538-bsl

Flashing instructions:

https://zigbee.blakadder.com/Sonoff_ZBDongle-P.html

https://nerdiy.de/howto-zigbee-einen-sonoff-zigbee-3-0-usb-dongle-plus-fuer-zigbee2mqtt-vorbereiten/#Bootloader_des_USB-Sticks_aktivieren
