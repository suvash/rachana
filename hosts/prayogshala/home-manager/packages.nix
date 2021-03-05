{ pkgs }:

with pkgs;

[
  # Essentials
  # wget
  cmake
  gnumake

  # Git family
  tig
  gitAndTools.diff-so-fancy

  # Media
  vlc

  # Pulseaudio tools
  paprefs
  ncpamixer
  pamixer
  pamix

  # Entertainment
  spotify
  playerctl

  # File manipulation
  ag
  ripgrep
  exa
  ranger
  tree
  visidata
  xsv
  pigz
  unzip
  multitail
  dos2unix

  # Help
  tldr

  # X server/window
  arandr
  flameshot
  xcape
  xautolock
  xss-lock
  xorg.xev
  libnotify

  # Hardware info
  lshw
  hwinfo
  hardinfo

  # System monitoring
  acpi
  htop
  iotop
  iftop
  dfc
  dstat
  powertop
  ncdu
  baobab
  vnstat
  lm_sensors

  # System info
  lsb-release
  usbutils
  pciutils
  dmidecode
  sysstat
  smartmontools

  # Network
  traceroute
  nmap
  speedtest-cli
  bandwhich

  # Terminals / shells
  kitty
  parallel
  mosh
  fasd
  tmux

  # DNS
  dnsutils
  whois

  # Learning
  anki

  # Clients
  kaggle

  # Cloud vendors
  awscli
  google-cloud-sdk

  # Infrastructure
  iamy
  sops
  terraform
  packer
  kubectl
  kubectx

  # Docker
  dive
  docker-credential-gcr
  docker-compose

  # Bling
  cmatrix

  # Fonts
  font-manager

  # i3 support
  i3status-rust

  # Linters etc
  nixfmt

  # Communication
  slack
  zoom-us
]
