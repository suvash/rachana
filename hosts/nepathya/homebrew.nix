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
      "svn" # for the fonts
    ];

    masApps = {
      "Bitwarden" = 1352778147;
      "DuckDuckGo Privacy Essentials" = 1482920575;
      "Hand Mirror" = 1502839586;
      "Mactracker" = 430255202;
      "NetSpot" = 514951692;
      "Save to Pocket" = 1477385213;
      "Slack" = 803453959;
      "Tailscale" = 1475387142;
      "TweetDeck" = 485812721;
      "Vimari" = 1480933944;
      "iNet Network Scanner" = 403304796;
    };

    casks = [
      "alfred"
      "amethyst"
      "anki"
      "brave-browser"
      "chrysalis"
      "coconutbattery"
      "disk-inventory-x"
      "docker"
      "emacs"
      "firefox"
      "font-fira-code"
      "font-ubuntu"
      "font-ubuntu-mono"
      "google-chrome"
      "iterm2"
      "karabiner-elements"
      "keepingyouawake"
      "keka"
      "kekaexternalhelper"
      "nordvpn"
      "signal"
      "whatsapp"
      "zoom"
    ];

  };
}
