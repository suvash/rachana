{ config, lib, pkgs, ... }:


let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager.git";
    rev = "209566c752c4428c7692c134731971193f06b37c";
    ref = "release-20.09";
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # host settings
      ./settings.nix

      # home manager
      (import "${home-manager}/nixos")

      # other modules
      ./yubikey.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Use grub boot loader with efi support
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  networking.hostName = "${config.settings.hostname}"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "${config.settings.timezone}";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X Server and autorun
  services.xserver.enable = true;
  services.xserver.autorun = true;

  # Configure keymap for X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "";
  services.xserver.xkbOptions = "";
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
    lightdm = {
      enable = true;
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

  # Autorandr
  services.autorandr.enable = true;

  # Vnstat
  services.vnstat.enable = true;

  # Enable the OpenSSH server.
  services.openssh.enable = true;

  # Virtualisation
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.settings.username} = {
    isNormalUser = true;
    description = "${config.settings.fullname}";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    git
  ];

  environment.variables = {
    TERMINAL = "${config.settings.terminal}";
    EDITOR = "${config.settings.editor}";
  };

  environment.etc."login-wallpapers/unsplash.png" = {
    mode = "0555";
    source = ../../common/wallpapers/login/unsplash.png;
  };

  # Packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.fonts = with pkgs; [
    ubuntu_font_family
    lohit-fonts.nepali
    powerline-fonts
    font-awesome_4
    font-awesome
    emacs-all-the-icons-fonts
  ];

  # Home manager
  home-manager.users.${config.settings.username} = {
    home.packages = with pkgs; [
      gnumake
      cmake

      gitAndTools.diff-so-fancy

      firefox
      google-chrome
      brave

      ag
      ripgrep
      exa
      bat
      fzf
      jq
      ranger
      visidata

      unzip
      dfc

      tmux

      sops

      tldr

      whois
      bind

      spotify
      playerctl

      kitty
      i3status-rust
      arandr
      vnstat

      libnotify

      xcape
      xautolock
      xss-lock
      feh
      flameshot

      awscli
      google-cloud-sdk
      iamy

      docker-compose

      kaggle

      kubectl
      kubectx

      slack
      zoom-us
    ];


    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };

    services.xcape.enable = true;
    services.pasystray.enable = true;
    services.udiskie.enable = true;
    services.unclutter.enable = true;

    services.dunst = {
      enable = true;
      settings = {
        global = {
          monitor = "0";
          follow = "keyboard";
          geometry = "500x5-30+20";
          progress_bar = "true";
          progress_bar_height = "10";
          progress_bar_frame_width = "1";
          progress_bar_min_width = "150";
          progress_bar_max_width = "300";
          indicate_hidden = "yes";
          shrink = "no";
          transparency = "0";
          notification_height = "0";
          separator_height = "2";
          padding = "8";
          horizontal_padding = "8";
          frame_width = "2";
          frame_color = "#aaaaaa";
          separator_color = "frame";
          sort = "yes";
          idle_threshold = "120";
          font = "Ubuntu Mono 14";
          line_height = "0";
          markup = "full";
          format = "<b>%s</b>\\n\\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = "60";
          word_wrap = "yes";
          ellipsize = "middle";
          ignore_newline = "no";
          stack_duplicates = "true";
          hide_duplicate_count = "false";
          show_indicators = "yes";
          icon_position = "left";
          min_icon_size = "0";
          max_icon_size = "64";
          # icon_path - injected
          sticky_history = "yes";
          history_length = "20";
          dmenu = "/usr/bin/dmenu -p dunst";
          browser = "${pkgs.firefox}/bin/firefox --private-window";
          always_run_script = "true";
          title = "Dunst";
          class = "Dunst";
          startup_notification = "false";
          verbosity = "mesg";
          corner_radius = "5";
        };
        shortcuts = {
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
          history = "ctrl+grave";
          context = "ctrl+shift+period";
        };
        urgency_low = {
          timeout = "8";
          background = "#222222";
          foreground = "#888888";
        };
        urgency_normal = {
          timeout = "12";
          background = "#285577";
          foreground = "#ffffff";
        };
        urgency_critical = {
          timeout = "0";
          background = "#900000";
          foreground = "#ffffff";
        };
      };
    };

    services.picom = {
      enable = true;
      inactiveDim = "0.2";
    };

    services.random-background = {
      enable = true;
      display = "tile";
      imageDirectory = "%h/.wallpapers/tiled";
      interval = "1h";
    };

    services.screen-locker = {
      enable = true;
      lockCmd = "${pkgs.i3lock}/bin/i3lock --nofork --image /etc/login-wallpapers/unsplash.png";
      inactiveInterval = 1;
    };

    services.caffeine.enable = true;
    services.clipmenu.enable = true;

    programs.rofi= {
      enable = true;
      font = "Ubuntu Mono 18";
      terminal = "${pkgs.kitty}/bin/kitty";
    };

   programs.kitty = {
     enable = true;
     settings = {
       font_family = "Ubuntu Mono";
       font_size = "16";
     };
   };

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
      if test -d "$HOME/.config/base16-shell"
        set BASE16_SHELL "$HOME/.config/base16-shell/"
        source "$BASE16_SHELL/profile_helper.fish"
      end
      '';
    };

    programs.emacs.enable = true;
    programs.gpg.enable = true;

    programs.git = {
      enable = true;
      userName = "${config.settings.fullname}";
      userEmail = "${config.settings.email}";
      ignores = [ ".tmp/" ];
      signing = {
        key = "${config.settings.gpgkey}";
        signByDefault = true;
      };
    };

    home.sessionPath = [ "/home/${config.settings.username}/.local/bin" ];

    home.file.".local/bin/configure-slimblade-trackball.sh".source = ./scripts/configure-slimblade-trackball.sh;
    home.file.".local/bin/configure-kensington-advantage.sh".source = ./scripts/configure-kensington-advantage.sh;

    home.file.".screenshots/.keep".text = "";

    home.file.".wallpapers" = {
      source = ../../common/wallpapers;
      recursive = true;
    };

    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";
        fonts = [ "Ubuntu Mono 14"];

        keybindings = lib.mkOptionDefault {
          ## Missing
          # Focus
          "Mod4+j" = "focus left";
          "Mod4+k" = "focus down";
          "Mod4+l" = "focus up";
          "Mod4+semicolon" = "focus right";
          # Move
          "Mod4+Shift+j" = "move left";
          "Mod4+Shift+k" = "move down";
          "Mod4+Shift+l" = "move up";
          "Mod4+Shift+semicolon" = "move right";

          ## Overrides
          "Mod4+Shift+e" = "exec xfce4-session-logout";
          "Mod4+d" = "exec rofi -show drun";

          ## Custom
          # Media player
          "Mod4+ctrl+6" = "exec playerctl previous";
          "Mod4+ctrl+8" = "exec playerctl play-pause";
          "Mod4+ctrl+0" = "exec playerctl next";
          "Mod4+ctrl+Up" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          "Mod4+ctrl+Down" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";

          # Utilities
          "Mod4+ctrl+l" = "exec i3lock --nofork --image /etc/login-wallpapers/unsplash.png";
          "Mod4+ctrl+w" = "exec feh --bg-tile --no-fehbg --randomize ~/.wallpapers/tiled";
          "Mod4+ctrl+v" = "exec CM_LAUNCHER=rofi clipmenu";
          "Mod4+ctrl+a" = "exec configure-slimblade-trackball.sh";
          "Mod4+ctrl+3" = "exec flameshot full --path ~/.screenshots";
          "Mod4+ctrl+4" = "exec flameshot gui --path ~/.screenshots";

          # Programs
          "Mod4+ctrl+e" = "exec emacs";
          "Mod4+ctrl+f" = "exec firefox";
          "Mod4+ctrl+b" = "exec brave --incognito";
          "Mod4+ctrl+c" = "exec google-chrome-stable --incognito";
          "Mod4+ctrl+s" = "exec spotify";
          "Mod4+ctrl+z" = "exec zoom-us";

          # Notifications
          "Mod4+ctrl+n" = "exec notify-send -t 4000 Network \"LAN: $(ip addr show eno1 | awk '/inet /{print $2}')\\nWAN: $(curl ifconfig.me)\"";
        };

        bars = [
          {
            fonts = [ "Ubuntu Mono, FontAwesome 14" ];
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./config/i3status/i3status-rust.toml}";
          }
        ];

        gaps = {
          inner = 10;
          smartGaps = true;
          smartBorders = "on";
        };
      };

      extraConfig = ''
        exec --no-startup-id ~/.local/bin/configure-slimblade-trackball.sh
        exec --no-startup-id ~/.local/bin/configure-kensington-advantage.sh
      '';
    };
  };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
