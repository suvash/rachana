#!/usr/bin/env bash

echo "Rebuilding and switching via nix-darwin"
darwin-rebuild switch

if ! $(finger $USER | grep -q '/run/current-system/sw/bin/fish'); then
  echo 'Setting fish as default shell, will need privileges.'

  chsh -s  /run/current-system/sw/bin/fish
fi
