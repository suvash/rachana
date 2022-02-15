{ pkgs }:

with pkgs;

[
  # Essentials
  coreutils # among many others needed for emacs dired
  gnumake

  # Git family
  tig
  gitAndTools.diff-so-fancy

  # Terminals / shells
  fasd
  tmux

  # Bling
  cmatrix
]
