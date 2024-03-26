{ pkgs }:

with pkgs;

[
  # Essentials
  # wget
  cmake
  gnumake

  # home-manager
  home-manager

  # CUDA
  # gcc
  # cudaPackages.cudatoolkit
  # cudaPackages.cuda-samples
  unstable.ollama

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
  #unstable.nvtopPackages.nvidia
  unstable.nvtopPackages.full
  unstable.nvitop
  unigine-valley
  gnome.cheese

  # Pulseaudio tools
  paprefs
  ncpamixer
  pamixer
  pamix

  # Entertainment
  spotify
  unstable.plex-media-player
  playerctl

  # Papers, Notes etc.
  zotero

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
  (unstable.google-cloud-sdk.withExtraComponents [unstable.google-cloud-sdk.components.kubectl
                                                  unstable.google-cloud-sdk.components.gke-gcloud-auth-plugin])

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
  nixfmt
  yamllint
  ispell
  shellcheck
  gron

  # Editors
  obsidian

  # Communication
  signal-desktop
  slack
  element-desktop
  zulip
  zoom-us
  webex
]
