{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    global = {
      brewfile = true;
    };

    taps = [
      "homebrew/core"
      "homebrew/cask"
      "homebrew/cask-versions"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"

      "d12frosted/emacs-plus"
    ];

    brews = [
      "svn" # for the fonts
      "neovim"
      "elixir"

      "rustup-init"
      "npm"

      {
        name = "emacs-plus";
        args = [ "with-modern-papirus-icon" "with-no-titlebar-and-round-corners" ];
      }

     "fontconfig"
    ];

    masApps = {
      "Bitwarden" = 1352778147;
      "Hand Mirror" = 1502839586;
      "Mactracker" = 430255202;
      "NetSpot" = 514951692;
      "Save to Pocket" = 1477385213;
      "Slack" = 803453959;
      "Tailscale" = 1475387142;
      "Vimari" = 1480933944;
      "iNet Network Scanner" = 403304796;
    };

    casks = [
      "alfred"
      "amethyst"
      "anki"
      "authy"
      "brave-browser"
      "chrysalis"
      "coconutbattery"
      "discord"
      "disk-inventory-x"
      "docker"
      "element"
      "firefox"
      "font-fira-code"
      "font-ubuntu"
      "font-ubuntu-mono"
      "google-chrome"
      "iterm2"
      "kitty"
      "karabiner-elements"
      "keepingyouawake"
      "kensingtonworks"
      "keka"
      "kekaexternalhelper"
      "nordvpn"
      "postman"
      "quarto"
      "signal"
      "spotify"
      "vlc"
      "visual-studio-code"
      "whatsapp"
      "zotero"
      "zoom"
    ];

  };
}
