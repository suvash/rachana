{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # host settings
    ./settings.nix

    # home manager settings
    ./home-manager/configuration.nix

    # intel
    ./intel_cpu.nix
    # ./intel_gpu.nix

    # nvidia
    ./nvidia_gpu.nix

    # virtualisation
    ./docker.nix

    # others
    ./yubikey.nix
    ./tailscale.nix
  ];

  # NIX =============================================================================

  # Enable experimental nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "${config.settings.username}" ];

  # BOOT ============================================================================

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Use grub boot loader with efi support
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  # --set-root being the /dev/disk/by-uuid/ of EFI partition
  boot.loader.grub.extraEntries = ''
    menuentry "Windows" {
      insmod part_gpt
      insmod fat
      insmod search_fs_uuid
      insmod chain
      search --fs-uuid --set=root 7EEE-E88E
      chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      insmod part_gpt
    }
  '';

  # Clean tmp dir on boot
  boot.tmp.cleanOnBoot = true;

  # NETWORKING ======================================================================

  # Define the hostname
  networking.hostName = "${config.settings.hostname}"; # Define your hostname.

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port 7531 ];
    allowedTCPPorts = [ 7531 ];
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  # HARDWARE ========================================================================

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # LOCALISATION ====================================================================

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ m17n ];
    };
  };

  # TIME ============================================================================

  # Set your time zone.
  time.timeZone = "${config.settings.timezone}";

  # Set hardware clock to local time
  time.hardwareClockInLocalTime = true;

  # Use chrony for ntp sync
  services.chrony.enable = true;

  # PACKAGES ========================================================================

  # Allow unfree packages
  nixpkgs.config = {
    # Allow proprietary packages
    allowUnfree = true;
    allowBroken = false;

    # Alias for the unstable channel
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        # pass the nixpkgs config to the unstable alias
        # to ensure `allowUnfree = true;` is propagated:
        config = config.nixpkgs.config;
      };
    };
  };

  # CONSOLE =========================================================================

  # Console font and keymap
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # ENVIRONMENT =====================================================================

  # Install packages
  environment.systemPackages = with pkgs; [ nano wget git ];

  # Env vars
  environment.variables = {
    TERMINAL = "${config.settings.terminal}";
    EDITOR = "${config.settings.editor}";
  };

  # Login/Lock screen image
  environment.etc."login-wallpapers/unsplash.png" = {
    mode = "0555";
    source = ../../common/wallpapers/login/unsplash.png;
  };

  # FONTS ===========================================================================

  # Fonts
  fonts.packages = with pkgs; [
    ubuntu_font_family
    roboto
    roboto-mono
    roboto-slab
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    lohit-fonts.devanagari
    lohit-fonts.nepali
    # nerdfonts
    # emacs-all-the-icons-fonts
  ];

  # PROGRAMS ========================================================================

  # GPG agent with SSH support
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable fish shell
  programs.fish.enable = true;

  # Enable nix-ld
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libgcc.lib # uvicorn
    ];
  };

  # Enable envfs
  # services.envfs.enable = true;


  # SECURITY ========================================================================

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  # VIRTUALISATION ==================================================================

  # Podman
  virtualisation.podman.enable = false;

  # XSERVER =========================================================================

  # Enable the X Server and autorun
  services.xserver.enable = true;
  services.xserver.autorun = true;

  # Configure keymap for X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";
  services.xserver.xkb.options = "";
  services.xserver.autoRepeatDelay = 200;
  services.xserver.autoRepeatInterval = 60;

  # Wacom
  services.xserver.wacom.enable = true;

  # Select a desktop manager - no window management
  services.xserver.desktopManager = {
    xterm.enable = false;
    xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
  };

  # Select a display/login manager
  services.displayManager.defaultSession = "xfce+i3";
  services.xserver.displayManager = {
    lightdm = {
      enable = true;
      # https://github.com/NixOS/nixpkgs/issues/108289#issuecomment-758263467
      extraSeatDefaults = ''
        user-session = xfce+i3
      '';
      greeters.mini = {
        enable = true;
        user = "${config.settings.username}";
        # https://github.com/prikhi/lightdm-mini-greeter/blob/master/data/lightdm-mini-greeter.conf
        extraConfig = ''
          [greeter]
          show-password-label = false
          show-input-cursor = false
          password-alignment = left

          [greeter-theme]
          background-image = "/etc/login-wallpapers/unsplash.png"
          # background-color = "#212E53"
          # window-color = "#EBACA2"
          # border-color = "#BED3C3"
          # border-width = 2px
          # layout-space = 15
          # password-background-color = "#212E53"
          # password-border-color = "#BED3C3"
          # password-border-width = 2px
          # password-border-radius = 0.0em
        '';
      };
    };
  };

  # Select a window manager
  services.xserver.windowManager = {
    i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  # SERVICES ========================================================================

  # Blink your eyes
  services.safeeyes.enable = true;

  # Avahi
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Vnstat
  services.vnstat.enable = true;

  # Fstrim
  services.fstrim.enable = true;

  # Enable the OpenSSH server.
  services.openssh.enable = true;

  # USERS ===========================================================================

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.settings.username} = {
    isNormalUser = true;
    description = "${config.settings.fullname}";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "docker" "audio" ];
    openssh = {
      authorizedKeys = {
        keyFiles = [
          (../../common/config/keys/ssh + "/${config.settings.username}.key")
        ];
      };
    };
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05";

}
