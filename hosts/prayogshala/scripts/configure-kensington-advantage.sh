#!/usr/bin/env bash

set -eu

kinesis_keyboard_id=$(xinput -list | awk -Fid= '/HID 05f3:0007  /{ print $2 }' | awk '{ print $1 }')
if [ "${kinesis_keyboard_id}" != "" ]; then
    setxkbmap -device "${kinesis_keyboard_id}" -model kinesis -layout 'us,se' -variant ',' -option 'grp:shifts_toggle,ctrl:nocaps'

    REPEAT_DELAY=200
    REPEAT_INTERVAL=60

    xset r rate $REPEAT_DELAY $REPEAT_INTERVAL

    SUBJECT="Found Kinesis Advantage ($(xinput -list --name-only $kinesis_keyboard_id))."
    BODY="Layouts : US,SE\nRepeat delay, interval : $REPEAT_DELAY, $REPEAT_INTERVAL\nCaps is set to Ctrl\nBoth shifts toggles Caps."

    notify-send --urgency=NORMAL "$SUBJECT" "$BODY"
fi
