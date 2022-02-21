#!/usr/bin/env bash

# Set channel to a release
# sudo nix-channel --add https://nixos.org/channels/nixos-21.11 nixos
# sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable

# Update channels
# sudo nix-channel --update nixos
# sudo nix-channel --update nixos-unstable

# Use the new configuration
sudo nixos-rebuild switch

# Collect unreachable path in nix store + all generations older and than 30d
# sudo nix-collect-garbage --delete-older-than 30d

