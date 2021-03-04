#!/usr/bin/env bash

if [ ! -L /etc/nixos/configuration.nix ]; then
  sudo mv /etc/nixos /etc/nixos.orig
  sudo mkdir -p /etc/nixos
  sudo ln -sfnv "$HOME/rachana/hosts/prayogshala/configuration.nix" /etc/nixos/configuration.nix
  sudo ln -sfnv "$HOME/rachana/hosts/prayogshala/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
fi

if [ ! -L "$HOME/.emacs.d" ]; then
 mv "$HOME/.emacs.d" "$HOME/.emacs.d.orig"
 ln -sfnv "$HOME/rachana/common/config/.emacs.d" "$HOME/.emacs.d"
fi

if [ ! -d "$HOME/.config/base16-shell" ]; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi
