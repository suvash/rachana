#!/usr/bin/env bash

# MACOS-only stuff. Abort if not MACOS.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Install nix if not already present
echo "-- Installing Nix if not already installed"
if [[ ! "$(type -P nix)" ]]; then
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi
echo "-- Nix is installed"

# Source and activate nix
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

# Install nix-darwin & home-manager
echo "-- Installing nix-darwin and home-manager"
if [[ ! "$(type -P nix)" ]]; then
  echo "Nix is not available, please make sure you run the bootstrap first."
  exit 1
else
  echo "-- Adding nixpkgs channel"
  nix-channel --remove nixpkgs
  nix-channel --add https://nixos.org/channels/nixpkgs-21.11-darwin
  nix-channel --list
  nix-channel --update

  echo "-- Installing home-manager channel"
  nix-channel --remove home-manager
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager
  nix-channel --list
  nix-channel --update

  echo "-- Installing nix-darwin"
  if [[ ! "$(type -P darwin-rebuild)" ]]; then
    mkdir -p "$HOME/Developer/nix-darwin/installer"
    mkdir -p "$HOME/Developer/nix-darwin/uninstaller"
    pushd $PWD
    # Not quite locked here, might have to use flakes somehow
    cd "$HOME/Developer/nix-darwin/installer"
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
    cd "$HOME/Developer/nix-darwin/uninstaller"
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A uninstaller
    cd "$HOME/Developer/nix-darwin/installer"
    ./result/bin/darwin-installer
    popd
  fi

  echo "-- Listing all the channels"
  nix-channel --list
fi


# Install brew if not already present
echo "-- Installing Homebrew if not already installed"
if [[ ! "$(type -P brew)" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew doctor
  mkdir ~/Casks
fi
echo "-- brew is installed"

# Clone rachana if not already present
echo "-- Cloning rachana if not already done"
if [[ ! -d "$HOME/Developer/rachana" ]]; then
  mkdir -p $HOME/Developer

  git clone https://github.com/suvash/rachana.git $HOME/Developer/rachana
  cd $HOME/Developer/rachana
  git remote remove origin
  git remote add origin git@github.com/suvash/rachana.git
  cd -
fi
echo "-- rachana is in place"
