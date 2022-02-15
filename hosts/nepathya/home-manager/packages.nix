{ pkgs }:

with pkgs;

[
  # Essentials

  # GNU bundles
  coreutils-full
  binutils
  findutils

  # GNU
  gawk
  gnused
  gnutar
  gnumake
  gnutls
  gnupg
  gnugrep

  # Git family
  tig
  delta

  # File & Directory tools
  bat
  exa
  fd
  fzf
  which
  less
  rlwrap
  ripgrep
  tree

  # Watchers followers etc
  watch
  multitail

  # Compression
  gzip
  unzip
  pigz

  # System tools
  htop
  lsof
  pstree

  # Disk tools
  dfc
  duf
  ncdu

  # Network tools
  iftop
  curl
  wget
  whois
  ngrep
  gping
  nmap

  # Cloud vendors
  awscli2
  google-cloud-sdk

  # Infrastructure
  iamy
  terraform

  # k8s
  kubectl
  kubectx
  stern

  # Development tools
  tokei
  pgcli

  # Documentation tools
  tldr

  # Terminals / shells
  fasd
  tmux
  mosh

  # Format parsers
  jq
  yq
  xsv

  # Encryption etc
  sops

  # Linters & Checkers etc
  ispell
  nixfmt
  yamllint
  shellcheck

  # Benchmark

  # Bling
  cmatrix
]
