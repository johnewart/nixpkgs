{ pkgs, config, lib, ... }:
with lib;
{
  options.host.profile =  {
    environment = mkOption {
      type = types.str;
      default = "personal";
   };
  };

  imports = [
    ./modules/neovim
    ./modules/emacs
    ./modules/tmux.nix
  ];

  config = {

    home.packages = with pkgs; [
      nix-prefetch

      gdb
      ctags
      binutils
      clang-tools
      nixpkgs-fmt
      shfmt

      python3.pkgs.black
      pyright
      cmake
      libtool

      dua
      pkgs.nixFlakes
      git
      tmux
      htop
      lazygit
      delta
      scc
      direnv
      (nix-direnv.override { enableFlakes = true; })
      fzf
      exa
      zoxide
      pinentry
      fd
      bat
      vivid
      ripgrep
      zsh
      oh-my-zsh
      less
      bashInteractive
      ncurses
      coreutils
      git
      pandoc

      # Java dev (maven, sbt, JDK 11, 17)
      openjdk17_headless
      maven
      sbt
      coursier

      kubectl
      terraform
    ] ++ (lib.optionals pkgs.stdenv.isLinux [
      strace
      psmisc
      glibcLocales
      rWrapper
    ]);

    home.enableNixpkgsReleaseCheck = false;
    home.stateVersion = "22.05";

    programs.home-manager.enable = true;

    programs.zsh = { 
      enable = true;

      initExtraBeforeCompInit = builtins.readFile ./configs/config.zsh;

      # Enable Oh-my-zsh
      oh-my-zsh = {
        enable = true;
        theme = "half-life";
        plugins = [ "git" "sudo" "docker" "kubectl" "ssh-agent" ];
      };

      enableCompletion = true;

      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.4.0";
            sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
          };
        }
      ];

      shellAliases  = {
          tf = "terraform";
          updatehome = "home-manager switch && . ~/.zshrc";
      };
    };

    programs.git = {
      enable = true;
      aliases = {
        undo = "reset HEAD~1 --mixed";
        amend = "commit -a --amend";
        prv = "!gh pr view";
        prc = "!gh pr create";
        prs = "!gh pr status";
        prm = "!gh pr merge -d";
        st = "status";
        ci = "commit";
        co = "checkout";
        w = "whatchanged";
        br = "branch";
        df = "diff";
        lg = "log";
        ss = "stash save";
        pom = "push origin main";
        prom = "pull --rebase origin main";
        ds = "!git --no-pager diff --stat -M -w";
        changes = "log --oneline --reverse";
        fork = "!sh -c 'git rev-list --boundary $1...$2 | grep ^- | cut -c2-'";
        graph = "log --graph --oneline --decorate";
        info = "config --list";
        pop = "!git stash apply && git stash clear";
        staged = "diff --cached";
        summary = "log --oneline";
        tags = "tag -n1 -l";
      };
      extraConfig = {
        color = {
          ui = "auto";
        };
        diff = {
          tool = "vimdiff";
          mnemonicprefix = true;
        };
        merge = {
          tool = "splice";
        };
        push = {
          default = "simple";
        };
        pull = {
          rebase = true;
        };
        core = {
          excludesfile = "~/.gitignore_global";
        };
        branch = {
          autosetupmerge = true;
        };
        rerere = {
          enabled = true;
        };
        include = {
          path = "~/.gitconfig.local";
        };
      };
    };
  };
}
