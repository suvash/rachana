{ config, pkgs, ... }:

{
  imports = [
    ../settings.nix
    <home-manager/nix-darwin>
  ];

  home-manager.users.${config.settings.username} = { pkgs, ... }: {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = false;
    };

    xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";

    home.packages = import ./packages.nix { inherit pkgs; };

    # Needed for smart card to work
    home.file.".gnupg/scdaemon.conf".text = "disable-ccid";

    # Tmux
    home.file.".tmux.conf".source = ../../../common/config/tmux/tmux.conf;
    home.file.".tmux-macos.conf".source = ../../../common/config/tmux/tmux-macos.conf;

    # Dig
    home.file.".digrc".source = ../../../common/config/dig/digrc;
  };
}
