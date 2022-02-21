#!/usr/bin/env bash

HOSTNAME="karkhana"
RACHANA="$HOME/.rachana"

if [ ! -L /etc/nixos/configuration.nix ]; then
  sudo mv /etc/nixos /etc/nixos.orig
  sudo mkdir -p /etc/nixos
  sudo ln -sfnv "$RACHANA/hosts/$HOSTNAME/configuration.nix" /etc/nixos/configuration.nix
  sudo ln -sfnv "$RACHANA/hosts/$HOSTNAME/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
fi

if [ ! -L "$HOME/.emacs.d" ]; then
 mv "$HOME/.emacs.d" "$HOME/.emacs.d.orig"
 ln -sfnv "$RACHANA/common/config/.emacs.d" "$HOME/.emacs.d"
fi

if [ ! -L "$HOME/.config/git" ]; then
 mv "$HOME/.config/git" "$HOME/.config/git.orig"
 ln -sfnv "$RACHANA/common/config/git" "$HOME/.config/git"
fi

if [ ! -d "$HOME/.config/base16-shell" ]; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

