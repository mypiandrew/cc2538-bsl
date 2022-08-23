#!/bin/bash
#
# Note the spelling error on disable (doh!)
#
# /dev/mpcie1-reset   -> /sys/class/gpio/gpio41/value
# /dev/mpcie1-wdisble -> /sys/class/gpio/gpio40/value
#
# Could also use :
#
# raspi-gpio set 41 op dh
# raspi-gpio set 41 op dl
#
# raspi-gpio set 40 op dh
# raspi-gpio set 40 op dl
#
#
#  MPCIE2 = Modem/SIM Side
#  MPCIE1 = Aux RF Card side
#
#
# Basic idea here is that these TI CC2652 chips have an easy flash mode which we can activate
# to enable the device to be flashed over serial rather than by a clunky JTAG arrangement.
#
# What happens is this if the module see's that it's nominatited DIO line has been pulled DOWN
# after the reset line has gone high then it switches into 'easy serial flash' BSL mode, and we
# can then use the handy python script to push the firmware into the module.
#
# This script essentially does the same work as the 'AUTO-BSL' bit inside the python programmer,
# we can control the lines directly so don't need this (or frankly have a USB-UART chip that has
# the needed DSR and RTS lines anyway)
#

echo "Invoking Zigbee module Flash mode"
echo "================================="
echo ""

echo "setting idle state"
echo 0 >/dev/mpcie1-reset
echo 0 >/dev/mpcie1-wdisble


echo "Setting Flash line low"
echo 1 >/dev/mpcie1-wdisble
sleep 1

echo -n "Resetting Module.."
echo 1 >/dev/mpcie1-reset
sleep 1
echo -n ".."
echo 0 >/dev/mpcie1-reset
sleep 1
echo "..Done"
echo "Setting Flash line high"
echo 0 >mpcie1-wdisble
echo "All Done!"
