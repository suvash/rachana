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
      "homebrew/cask-versions"
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
      "Todoist" = 585829637;
      "Blinks" = 998804308;
    };

    casks = [
      "amethyst"
      "anki"
      "authy"
      "arc"
      "brave-browser"
      "blackhole-16ch"
      "chrysalis"
      "coconutbattery"
      "cursor"
      "discord"
      "disk-inventory-x"
      "docker"
      "firefox"
      "figma"
      "font-fira-code"
      "font-ubuntu"
      "font-ubuntu-mono"
      "google-chrome"
      "iterm2"
      "thunderbird"
      "karabiner-elements"
      "keepingyouawake"
      "kensingtonworks"
      "keka"
      "kekaexternalhelper"
      "kindle"
      "kitty"
      "libreoffice"
      "linear-linear"
      "notion"
      "obsidian"
      "postman"
      "raycast"
      "signal"
      "spotify"
      "send-to-kindle"
      "vlc"
      "visual-studio-code"
      "webex"
      "wacom-tablet"
      "whatsapp"
      "zotero"
      "zoom"
      "zulip"
      "zed"
    ];

  };
}
