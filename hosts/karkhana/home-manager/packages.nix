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
  git-lfs
  delta

  # Media
  vlc

  # Pulseaudio tools
  paprefs
  ncpamixer
  pamixer
  pamix

  # Entertainment
  spotify
  apple-music-electron
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
  brightnessctl
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
  lsof

  # System monitoring
  acpi
  htop
  bottom
  procs
  iotop
  iftop
  dfc
  duf
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
  iw
  ethtool
  traceroute
  gping
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

  # Audit etc
  unstable.lynis

  # Communication
  slack
  discord
  zoom-us
]
