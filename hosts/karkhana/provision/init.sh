#!/usr/bin/env bash

HOSTNAME="karkhana"
RACHANA="$HOME/.rachana"

if [ ! -L /etc/nixos/configuration.nix ]; then
  sudo mv /etc/nixos /etc/nixos.orig
  sudo mkdir -p /etc/nixos
  sudo ln -sfnv "$RACHANA/hosts/$HOSTNAME/configuration.nix" /etc/nixos/configuration.nix
  sudo ln -sfnv "$RACHANA/hosts/$HOSTNAME/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
fi

if [ ! -L "$HOME/.config/git" ]; then
 mv "$HOME/.config/git" "$HOME/.config/git.orig"
 ln -sfnv "$RACHANA/common/config/git" "$HOME/.config/git"
fi

if [ ! -d "$HOME/.config/base16-shell" ]; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi


if [ ! -d "$HOME/.emacs.d" ]; then
  git clone https://github.com/plexus/chemacs2.git ~/.emacs.d
  ln -sfnv "$RACHANA/common/config/chemacs/emacs-profiles.el" "$HOME/.emacs-profiles.el"
  ln -sfnv "$RACHANA/common/config/chemacs/emacs-profile" "$HOME/.emacs-profile"
fi

if [ ! -L "$HOME/.config/legacy-emacs.d" ]; then
  rm -rf "$HOME/.config/legacy-emacs.d"
  ln -sfnv "$RACHANA/common/config/.emacs.d" "$HOME/.config/legacy-emacs.d"
fi

if [ ! -d "$HOME/.config/doom-emacs.d" ]; then
  git clone https://github.com/hlissner/doom-emacs ~/.config/doom-emacs.d
  ~/.config/doom-emacs.d/bin/doom install
  ~/.config/doom-emacs.d/bin/doom doctor
fi

if [ ! -d "$HOME/.config/vanilla-emacs.d" ]; then
  mkdir ~/.config/vanilla-emacs.d
fi
