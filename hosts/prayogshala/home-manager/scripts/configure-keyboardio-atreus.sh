#!/usr/bin/env bash

set -eu

atreus_keyboard_id=$(xinput -list | awk -Fid= '/Keyboardio Atreus Keyboard/{ print $2 }' | awk '{ print $1 }')
if [ "${atreus_keyboard_id}" != "" ]; then
    setxkbmap -device "${atreus_keyboard_id}" -model atreus -layout 'us' -variant '' -option ''

    REPEAT_DELAY=200
    REPEAT_INTERVAL=60

    xset r rate $REPEAT_DELAY $REPEAT_INTERVAL

    SUBJECT="Found Keyboardio Atreus ($(xinput -list --name-only $atreus_keyboard_id))."
    BODY="Layouts : US\nRepeat delay, interval : $REPEAT_DELAY, $REPEAT_INTERVAL"


    notify-send --urgency=NORMAL "$SUBJECT" "$BODY"
fi
