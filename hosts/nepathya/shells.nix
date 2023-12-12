{ config, pkgs, lib, ... }:

{
  environment.shells = with pkgs; [ bashInteractive fish zsh ];

  environment.loginShell = "${pkgs.fish}/bin/fish -l";
  environment.variables.SHELL = "${pkgs.fish}/bin/fish";

  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Needed to address bug where $PATH is not properly set for fish:
  # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-482462491
  programs.fish.shellInit = ''
    for p in (string split : ${config.environment.systemPath})
      if not contains $p $fish_user_paths
        set -g fish_user_paths $fish_user_paths $p
      end
    end

    fish_add_path $HOME/.cargo/bin
    fish_add_path /usr/local/sbin
  '';
}
