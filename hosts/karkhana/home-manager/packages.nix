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
  playerctl

  # File manipulation
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
  silver-searcher

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

  # Video devices
  v4l-utils
  gnome.cheese

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
  zellij

  # DNS
  dnsutils
  whois

  # Cloud vendors
  awscli
  (unstable.google-cloud-sdk.withExtraComponents [unstable.google-cloud-sdk.components.kubectl
                                                  unstable.google-cloud-sdk.components.gke-gcloud-auth-plugin])


  # Infrastructure
  iamy
  sops
  terraform
  packer
  kubectx
  stern

  # Docker
  dive
  docker-credential-gcr
  docker-compose

  # Bling
  cmatrix
  unstable.hollywood

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
