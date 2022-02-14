{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";

    global = {
      brewfile = true;
      noLock = true;
    };

   taps = [
    "homebrew/core"
    "homebrew/cask"
    "homebrew/cask-versions"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
   ];

   brews = [
     "mas"
     "svn" # for the fonts
   ];

   masApps = {
    "Slack" = 803453959;
    "Tailscale" = 1475387142;
    "Hand Mirror" = 1502839586;
    "Bitwarden" = 1352778147;
    "iNet Network Scanner" = 403304796;
    "NetSpot" = 514951692;
   };

   casks = [
     "emacs"
     "karabiner-elements"
     "keepingyouawake"
     "zoom"

     "font-ubuntu"
     "font-ubuntu-mono"
     "font-fira-code"
   ];

   extraConfig = ''
     cask_args appdir: "~/Casks", require_sha: true
   '';

  };
}
