{ pkgs }:

with pkgs;

[
  # Essentials
  gnumake

  # Git family
  tig
  gitAndTools.diff-so-fancy

  # Terminals / shells
  fasd

  # Bling
  cmatrix
]
