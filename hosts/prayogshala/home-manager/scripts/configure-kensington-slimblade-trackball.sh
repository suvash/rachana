#!/usr/bin/env bash

set -eu

slimblade_trackball_id=$(xinput -list | awk -Fid= '/Slimblade Trackball/{ print $2 }' | awk '{ print $1 }')
if [ "${slimblade_trackball_id}" != "" ]; then
    # http://wiki.mbirth.de/know-how/software/linux/remapping-mouse-buttons.html
    # Swapping 1/3 (left/right) and 2/8 (middle/thumb1) for left hand usage
    xinput set-button-map "${slimblade_trackball_id}" 3 8 1 4 5 6 7 2 9 10 11 12
    # threshold accelNum accelDenom
    xinput set-ptr-feedback "${slimblade_trackball_id}" 12 8 2

    SUBJECT="Found $(xinput -list --name-only $slimblade_trackball_id)."
    BODY="Configured the trackball for left hand usage."

    notify-send --urgency=NORMAL "$SUBJECT" "$BODY"
fi
