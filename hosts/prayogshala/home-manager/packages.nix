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

  # Audio
  vcv-rack
  sonic-visualiser
  audacity

  # Nix tools
  nix-prefetch-git

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
  fd
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
  tokei

  # X server/window
  arandr
  flameshot
  xcape
  xautolock
  xss-lock
  xorg.xev
  libnotify
  xclip

  # Hardware info
  lshw
  hwinfo
  hardinfo
  lm_sensors

  # System monitoring
  acpi
  htop
  procs
  iotop
  iftop
  dfc
  unstable.du-dust
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
  konsole
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
  stern
  k9s

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
  yamllint
  ispell
  shellcheck

  # Communication
  slack
  zoom-us
]
