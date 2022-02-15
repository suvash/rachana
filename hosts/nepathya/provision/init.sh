#!/usr/bin/env bash

mkdir -p $HOME/.config
mkdir -p $HOME/.screenshots

echo "-- Setting up darwin-configuration symlink"
if [ ! -L "$HOME/.nixpkgs/darwin-configuration.nix" ]; then
  mkdir -p "$HOME/.nixpkgs/"
  mv "$HOME/.nixpkgs/darwin-configuration.nix" "$HOME/.nixpkgs/darwin-configuration.nix.orig"
  ln -sfnv "$HOME/Developer/rachana/hosts/nepathya/configuration.nix" "$HOME/.nixpkgs/darwin-configuration.nix"
fi

echo "-- Setting up emacs configuration symlink"
if [ ! -L "$HOME/.emacs.d" ]; then
  mv "$HOME/.emacs.d" "$HOME/.emacs.d.orig"
  ln -sfnv "$HOME/Developer/rachana/common/config/.emacs.d" "$HOME/.emacs.d"
fi

echo "-- Setting up git configuration symlink"
if [ ! -L "$HOME/.config/git" ]; then
  mv "$HOME/.config/git" "$HOME/.config/git.orig"
  ln -sfnv "$HOME/Developer/rachana/common/config/git" "$HOME/.config/git"
fi

echo "-- Setting up iTerm2 configuration symlink"
if [ ! -L "$HOME/.config/iterm2/com.googlecode.iterm2.plist" ]; then
  mkdir -p "$HOME/.config/iterm2"
  mv "$HOME/.config/iterm2/com.googlecode.iterm2.plist" "$HOME/.config/iterm2/com.googlecode.iterm2.plist.orig"
  ln -sfnv "$HOME/Developer/rachana/common/config/iterm2/com.googlecode.iterm2.plist" "$HOME/.config/iterm2/com.googlecode.iterm2.plist"
fi

echo "-- Setting up Karabiner elements configuration symlink"
if [ ! -L "$HOME/.config/karabiner/karabiner.json" ]; then
  mkdir -p "$HOME/.config/karabiner"
  rm -rf "$HOME/.config/karabiner/karabiner.json" 2> /dev/null
  ln -sfnv "$HOME/Developer/rachana/common/config/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
fi

echo "-- Cloning down base16-shell symlink"
if [ ! -d "$HOME/.config/base16-shell" ]; then
  mkdir -p "$HOME/.config"
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi
