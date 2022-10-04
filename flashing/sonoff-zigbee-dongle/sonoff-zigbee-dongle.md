# Sonoff Zigbee Dongle Flashing Z-Stack 3.X.0

## Requirements
- unzip
- wget
- [virtualenv](https://virtualenv.pypa.io/en/stable/) (You can also use some other kind of python environment, but then you will have to adapt the `setup.sh` script accordingly.)

## Install dependencies
Executing the `setup.sh` script will install all required scripts + a python environment for you:
```
./setup.sh
```

## Source your python environment
Ensure you have a working python environment
```
source ${HOME}/.venv/sonoff_zigbee_dongle/bin/activate
python --version
```

## Usage
Flashing should take 10-15 seconds, depending on your system and network connection.

### Flash latest coordinator firmware
`./flash_sonoff_zigbee_dongle.sh`

### Flash specific coordinator firmware
`FIRMWARE_VERSION="Z-Stack_Home_3.x.0_20211217" ./flash_sonoff_zigbee_dongle.sh`

### Flash latest router firmware
`FIRMWARE_TYPE=router ./flash_sonoff_zigbee_dongle.sh`

### Flash specific router firmware
`FIRMWARE_VERSION="3275288c3a9497b4073604156e887778485c1b34" FIRMWARE_TYPE=router ./flash_sonoff_zigbee_dongle.sh`

## Thanks to

Bootloader Activation Script:

https://github.com/Nerdiyde/Sonoff_zigbee_3.0_USB_dongle_plus_bootloader_script

Flashing Tool:

https://github.com/JelmerT/cc2538-bsl

Flashing instructions:

https://zigbee.blakadder.com/Sonoff_ZBDongle-P.html

https://nerdiy.de/howto-zigbee-einen-sonoff-zigbee-3-0-usb-dongle-plus-fuer-zigbee2mqtt-vorbereiten/#Bootloader_des_USB-Sticks_aktivieren
