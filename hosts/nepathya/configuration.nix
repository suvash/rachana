{ config, pkgs, ... }:

{
  # Imports
  imports = [
    # host settings
    ./settings.nix

    # system settings
    ./macos.nix

    # shells
    ./shells.nix

    # home manager
    ./home-manager/configuration.nix
    ./home-manager/fish.nix

    # homebrew
    ./homebrew.nix
  ];

  # NIX =============================================================================

  # Enable experimental nix command and flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # NETWORKING ======================================================================

  networking = {
    computerName = "${config.settings.computername}";
    hostName = "${config.settings.hostname}";
    localHostName = "${config.settings.hostname}";

    # cloudflare dns
    dns = [
     "1.1.1.1"
     "1.0.0.1"
     "2606:4700:4700::1111"
     "2606:4700:4700::1001"
    ];

    # networksetup -listallnetworkservices
    knownNetworkServices = [
     "Wi-Fi"
     "Apple USB Ethernet Adapter"
     "Thunderbolt Bridge"
    ];
  };

  # ENVIRONMENT =====================================================================

  # System level packages
  environment.systemPackages = with pkgs; [
    terminal-notifier
  ];

  # Env vars
  environment.variables = {
    LANG = "en_US.UTF-8";
    EDITOR = "${config.settings.editor}";
  };

  # FONTS ===========================================================================

  # Fonts
  fonts.fonts = with pkgs; [
  ];

  # PROGRAMS ========================================================================

  # GPG agent with SSH support
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # USERS ===========================================================================

  users.users.${config.settings.username} = {
    name = "${config.settings.username}";
    home = "/Users/${config.settings.username}";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
