#!/usr/bin/env bash

set -eu

light_theme="Adwaita"
dark_theme="Adwaita-dark"

current_theme=$(xfconf-query -c xsettings -p /Net/ThemeName)

if [ "$current_theme" == "$light_theme" ]; then
    new_theme=$dark_theme
elif [ "$current_theme" == "$dark_theme" ]; then
    new_theme=$light_theme
else
    new_theme=$current_theme
fi

CMD="xfconf-query -c xsettings -p /Net/ThemeName -s $new_theme"
SUBJECT="Toggling dark/light theme"
BODY="$current_theme ➡️ $new_theme"

notify-send --urgency=NORMAL "$SUBJECT" "$BODY"
eval $CMD
