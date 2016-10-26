#!/bin/bash

# Avoid errors
sleep 0.2

#status=$(synclient -l | grep TouchpadOff | awk '{print $3}')
#if [ $status -eq 1 ]; then
    #status=0
    #notify-send --urgency=low  -i /usr/share/icons/HighContrast/48x48/devices/input-touchpad.png "Touchpad enabled." "Press <fn + F1> to toggle."
#else 
    #status=1
    #notify-send --urgency=low  -i /usr/share/icons/HighContrast/48x48/devices/input-touchpad.png "Touchpad disabled." "Press <fn + F1> to toggle."
#fi
#synclient TouchpadOff=$status

TOUCHPAD_XINPUT_ID=$(xinput | grep 'TouchPad' | awk '{print $6}' | sed 's/id=//')
TOUCHPAD_STATUS=$(xinput list-props $TOUCHPAD_XINPUT_ID | grep 139 | awk '{print $4}')
if [ $TOUCHPAD_STATUS -eq 1 ]; then
  xinput set-prop $TOUCHPAD_XINPUT_ID 139 0
else
  xinput set-prop $TOUCHPAD_XINPUT_ID 139 1
fi
