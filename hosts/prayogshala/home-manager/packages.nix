{ pkgs }:

with pkgs;

[
  # Essentials
  # wget
  cmake
  gnumake

  # home-manager
  home-manager

  # Nix
  nix-index

  # Git family
  tig
  gitAndTools.diff-so-fancy
  git-lfs
  delta

  # Media
  vlc

  # Audio
  vcv-rack
  sonic-visualiser
  audacity

  # Nix tools
  nix-prefetch-git

  # Graphics tools
  glxinfo
  unstable.nvtopPackages.full
  unstable.nvitop
  cheese

  # Pulseaudio tools
  paprefs
  ncpamixer
  pamixer
  pamix

  # Entertainment
  spotify
  playerctl

  # Papers, Notes etc.
  zotero
  calibre

  # File manipulation
  silver-searcher
  fd
  ripgrep
  ranger
  tree
  visidata
  xsv
  pigz
  unzip
  multitail
  dos2unix
  zip
  catdoc # xls2csv
  xlsx2csv 

  # Help
  tealdeer
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
  lsof

  # System monitoring
  acpi
  htop
  btop
  pstree
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
  cool-retro-term

  # Editors
  zed-editor

  # DNS
  dnsutils
  whois

  # Learning
  unstable.anki

  # Clients
  kaggle

  # Cloud vendors
  cloudflared
  awscli

  # Infrastructure
  iamy
  sops
  terraform
  packer
  # kubectl
  kubectx
  stern
  k9s

  # Programming
  gforth

  # Docker
  dive
  docker-credential-gcr
  docker-compose

  # Bling
  cmatrix

  # Credentials
  # authy

  # Fonts
  font-manager

  # i3 support
  i3status-rust

  # Linters etc
  yamllint
  ispell
  shellcheck
  gron

  # Editors
  obsidian
  libreoffice

  # Database
  pgcli

  # Communication
  thunderbird
  signal-desktop
  slack
  element-desktop
  zulip
  zoom-us
]
