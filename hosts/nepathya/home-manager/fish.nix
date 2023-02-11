{ config, pkgs, ... }:

{
  imports = [ ../settings.nix <home-manager/nix-darwin> ];

  home-manager.users.${config.settings.username} = { pkgs, ... }: {
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
          "git stash; and git fetch --all -p; and git rebase -p '@{upstream}'; and git stash pop";
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
        mi = "bash ~/Developer/rachana/hosts/(hostname)/provision/init.sh";
        mb = "bash ~/Developer/rachana/hosts/(hostname)/provision/build.sh";

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

        # nvim
        n = "nvim";
        nb = "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'";

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
  };
}
