{ pkgs }:

with pkgs;

[
  # Essentials
  coreutils-full
  binutils
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
