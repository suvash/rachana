{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager.git";
    rev = "3cd5c21b80ee4f340cf2f1319e0529ca559ef50f";
    ref = "release-22.11";
  };
in {
  imports = [
    # host settings
    ../settings.nix

    # home manager
    (import "${home-manager}/nixos")
  ];

  home-manager.users.${config.settings.username} = {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = false;
    };

    home.packages = import ./packages.nix { inherit pkgs; };
    home.stateVersion = "22.11";

    services.xcape = {
      enable = true;
      mapExpression = { Control_L = "Escape"; };
    };

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

    services.picom = { enable = true; };

    services.random-background = {
      enable = true;
      display = "tile";
      imageDirectory = "%h/.wallpapers/tiled";
      interval = "1h";
    };

    services.screen-locker = {
      enable = true;
      lockCmd =
        "${pkgs.i3lock}/bin/i3lock --nofork --image /etc/wallpapers/lock.png";
      inactiveInterval = 1;
    };

    services.caffeine.enable = true;
    services.clipmenu.enable = true;

    programs.autorandr.enable = true;
    programs.bat.enable = true;
    programs.feh.enable = true;
    programs.jq.enable = true;

    programs.brave.enable = true;
    programs.firefox.enable = true;
    programs.chromium.enable = true;
    programs.qutebrowser.enable = true;

    programs.emacs.enable = true;
    programs.vscode.enable = true;
    programs.neovim.enable = true;
    programs.vim.enable = true;

    programs.nushell.enable = true;

    programs.zathura.enable = true;

    programs.direnv.enable = true;

    programs.mpv.enable = true;
    programs.obs-studio.enable = true;

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.gh = {
      enable = true;
      settings = { git_protocol = "ssh"; };
    };

    programs.rofi = {
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
      shellAbbrs = {
        # listing
        "..." = "../..";
        l = "exa -la";
        b = "bat --show-all";
        v = "vim (fzf)";
        ll = "ls -lah";
        lsd = "tree --dirsfirst -ChF -L 1";

        # git things
        ga = "git add";
        gs = "git show --stat";
        gst = "git status -sb";
        gd = "git diff";
        gdc = "git diff --cached";
        gp = "git push";
        gpf = "git push --force-with-lease";
        gpu = "git push --set-upstream origin (git branch --show-current)";
        gpd = "git push --delete origin (git branch --show-current)";
        gsu = "git submodule update";
        gup =
          "git fetch --all --prune --prune-tags; and git rebase --rebase-merges '@{upstream}'";
        gsp =
          "git stash; and git fetch --all -p; and git rebase --rebase-merges '@{upstream}'; and git stash pop";
        gprn = "git remote prune origin --dry-run";
        gm = "git merge --no-ff --log";
        gc = "git commit -v";
        gca = "git commit -v --amend";
        gco = "git checkout";
        gcob = "git checkout -b";
        gcm = "git checkout main";
        gcms = "git checkout master";
        gb = "git branch";
        gbr = "git branch -r";
        gbd = "git branch --delete";
        gbdf = "git branch --delete --force";
        gcp = "git cherry-pick";
        gl = "git log --oneline --decorate=full";
        grhh = "git reset HEAD --hard";
        gcln = "git clean -f -d";
        gdmlb = "git branch --merged | grep -v '*' | xargs -n 1 git branch -d";
        grbm = "git rebase -i (git show-branch --merge-base main)";
        grbms = "git rebase -i (git show-branch --merge-base master)";

        # nix things
        ns = "nix search";
        nss = "nix-env -qaP --description '.*<here>.*'";

        # provisioning things
        mi = "bash ~/.rachana/hosts/(hostname)/provision/init.sh";
        mb = "bash ~/.rachana/hosts/(hostname)/provision/build.sh";

        # docker things
        di = "docker image ls";
        dc = "docker container ls";
        dn = "docker network ls";
        dv = "docker volume ls";
        ds = "docker system df";
        dprn = "docker system prune --volumes";

        # tmux things
        t = "tmux new";
        ta = "tmux attach";
        tls = "tmux list-sessions";

        # terminal themes
        td = "base16-onedark";
        tl = "base16-one-light";

        # gpg things
        gpgrst = "gpg-connect-agent --quiet updatestartuptty /bye";

        # monitor
        p1 = "ping 1.1.1.1";
        pcf = "ping cfl.re";
        pgg = "ping goo.gl";
        ports = "netstat -tunap";

        # system
        dmsg = "dmesg -w -L";
        # other
        du = "du -chs *";
        fonts = "fc-list : family";
        httpserve = "python -m http.server 7531";
        kssh = "kitty +kitten ssh";
      };
      functions = {
        cleansshhosts = ''
          awk -F',' "/$argv/"'{print $1}'  ~/.ssh/known_hosts | xargs -r -n 1 ssh-keygen -R'';
        thanksfish = "set -U fish_greeting";
      };
      plugins = [{
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "38a5b6b6011106092009549e52249c6d6f501fba";
          sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
        };
      }];
    };

    home.sessionPath = [ "/home/${config.settings.username}/.local/bin" ];

    home.file.".screenshots/.keep".text = "";

    home.file.".wallpapers" = {
      source = ../../../common/wallpapers;
      recursive = true;
    };

    home.file.".tmux.conf".source = ../../../common/config/tmux/tmux.conf;

    home.file.".digrc".source = ../../../common/config/dig/digrc;

    xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";

    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";
        fonts = {
          names = [ "Ubuntu Mono" ];
          size = 14.0;
          style = "";
        };

        keybindings = lib.mkOptionDefault {
          ## Missing
          # Backlight
          "XF86KbdBrightnessUp" = "exec brightnessctl set +10%";
          "XF86KbdBrightnessDown" = "exec brightnessctl set 10%-";

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
          "Mod4+ctrl+l" =
            "exec i3lock --nofork --image /etc/wallpapers/lock.png";
          "Mod4+ctrl+w" =
            "exec feh --bg-tile --no-fehbg --randomize ~/.wallpapers/tiled";
          "Mod4+ctrl+v" = "exec CM_LAUNCHER=rofi clipmenu";
          "Mod4+ctrl+k" = "exec ~/.local/bin/configure-kensington-advantage.sh";
          "Mod4+ctrl+t" = "exec ~/.local/bin/toggle-xfce-dark-light-theme.sh";
          "Mod4+ctrl+3" = "exec flameshot full --path ~/.screenshots";
          "Mod4+ctrl+4" = "exec flameshot gui --path ~/.screenshots";

          # Programs
          "Mod4+ctrl+e" = "exec emacs";
          "Mod4+ctrl+f" = "exec firefox";
          "Mod4+ctrl+b" = "exec brave --incognito";
          "Mod4+ctrl+c" = "exec chromium --incognito";
          "Mod4+ctrl+q" = "exec qutebrowser";
          "Mod4+ctrl+s" = "exec spotify";
          "Mod4+ctrl+z" = "exec zoom-us";
          "Mod4+ctrl+x" = "exec systemctl --user restart xcape";

          # Notifications
          "Mod4+ctrl+d" = ''
            exec notify-send -t 4000 Date/Time "$(date)"
          '';
          "Mod4+ctrl+n" = ''
            exec notify-send -t 4000 Network "LAN: $(ip route get $(ip route show default | grep -oP 'via \K\S+') | grep -oP 'src \K\S+')"
          '';
        };

        bars = [
          {
            fonts = {
              names = [ "Ubuntu Mono" "FontAwesome" ];
              size = 12.0;
            };
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${
                ./config/i3status/laptop.toml
              }";
            extraConfig = ''
              output primary
            '';
          }
          {
            fonts = {
              names = [ "Ubuntu Mono" "FontAwesome" ];
              size = 12.0;
            };
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${
                ./config/i3status/monitor.toml
              }";
            extraConfig = ''
              output nonprimary
            '';
          }
        ];

        gaps = {
          inner = 10;
          smartGaps = true;
          smartBorders = "on";
        };
      };

      extraConfig = "";
    };
  };
}
