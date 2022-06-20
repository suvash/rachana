{ config, pkgs, ... }:

{
  imports = [ # Use hardware support
    <nixos-hardware/dell/xps/13-9360>
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # host settings
    ./settings.nix

    # home manager
    ./home-manager/configuration.nix

    # hidpi
    ./hidpi.nix

    # yubikey
    ./yubikey.nix

    # tailscale
    # ./tailscale.nix
  ];

  # BOOT ============================================================================

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    lukrypted = {
      device = "/dev/disk/by-uuid/3102aa30-6203-41a1-84a5-9547dfc3512c";
      allowDiscards = true;
      preLVM = true;
    };
  };

  boot.cleanTmpDir = true;

  # NETWORKING ======================================================================

  # Define the hostname
  networking.hostName = "${config.settings.hostname}";

  # Use network manager instead of wpa_supplicant, nmcli/nmtui
  networking.networkmanager.enable = true;

  # Use specific nameservers
  # Google NS
  # networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
  # Cloudflare NS
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    # trustedInterfaces = [ "tailscale0" ];
    # allowedUDPPorts = [ config.services.tailscale.port 7531 ];
    # allowedUDPPorts = [ 7531 ];
    allowedUDPPorts = [ ];
    allowedTCPPorts = [ ];
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp58s0.useDHCP = true;
  # networking.interfaces.enp0s20f0u1.useDHCP = true;

  # HARDWARE ========================================================================

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = null; # let tlp daemon manage this
    powertop = { enable = true; };
  };

  # Firmware update service
  services.fwupd.enable = true;

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
    font = "latarcyrheb-sun32";
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
  environment.etc."wallpapers/login.png" = {
    mode = "0555";
    source = ../../common/wallpapers/whole/orion-hubble.png;
  };

  environment.etc."wallpapers/lock.png" = {
    mode = "0555";
    source = ../../common/wallpapers/whole/orion-hubble.png;
  };

  # FONTS ===========================================================================

  # Fonts
  fonts.fonts = with pkgs; [
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
    nerdfonts
    emacs-all-the-icons-fonts
  ];

  # PROGRAMS ========================================================================

  # GPG agent with SSH support
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # SECURITY ========================================================================

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  # VIRTUALISATION ==================================================================

  # Podman
  virtualisation.podman.enable = false;

  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  # XSERVER =========================================================================

  # Enable the X Server and autorun
  services.xserver.enable = true;
  services.xserver.autorun = true;

  # Configure keymap for X11
  services.xserver.layout = "us,us";
  services.xserver.xkbVariant = "dvorak,";
  services.xserver.xkbOptions = "grp:shifts_toggle,ctrl:nocaps";
  services.xserver.autoRepeatDelay = 200;
  services.xserver.autoRepeatInterval = 60;

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
  services.xserver.displayManager = {
    defaultSession = "xfce+i3";
    sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
      # 3840x2160 on 27" -> 163
      # 2560x1440 on 27" -> 109
      Xft.dpi: 163
      EOF
    '';
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
          background-image = "/etc/wallpapers/login.png"
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

  # Touchpad
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      disableWhileTyping = true;
      scrollMethod = "twofinger";
      naturalScrolling = false;
      middleEmulation = true;
    };

  };

  # SERVICES ========================================================================

  # Avahi
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Logrotate
  services.logrotate.enable = true;

  # Disable the OpenSSH server.
  services.openssh.enable = false;

  # Vnstat
  services.vnstat.enable = true;

  # Fstrim
  services.fstrim.enable = true;

  # Enable ACPI daemon
  services.acpid.enable = true;

  # Enable UPower service
  services.upower.enable = true;

  # Enable TLP daemon
  services.tlp.enable = true;

  # Usbmuxd (Data to/from iOS)
  services.usbmuxd.enable = true;

  # Printing with CUPS
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  # USERS ===========================================================================

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.settings.username} = {
    isNormalUser = true;
    description = "${config.settings.fullname}";
    extraGroups = [ "wheel" "docker" "audio" ];
    shell = pkgs.fish;
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
  system.stateVersion = "21.11"; # Did you read the comment?

}
