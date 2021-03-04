{ pkgs }:

with pkgs;

[
  # Essentials
  # wget
  cmake
  gnumake

  # Editors
  # vim
  neovim

  # Git family
  # git
  tig
  gitAndTools.diff-so-fancy

  # Media
  vlc
  zathura

  # Pulseaudio tools
  paprefs
  ncpamixer
  pamixer
  pamix

  # Entertainment
  spotify
  playerctl

  # Browsers
  firefox
  google-chrome
  brave
  qutebrowser

  # File manipulation
  ag
  ripgrep
  exa
  bat
  fzf
  jq
  ranger
  tree
  visidata
  xsv
  pigz
  jq
  unzip
  multitail
  dos2unix

  # Help
  tldr

  # X server/window
  feh
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
  # htop
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
  tmux
  parallel
  mosh
  fasd

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
