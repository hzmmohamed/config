{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.tools.misc;
in {
  options.caramelmint.tools.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.configFile."wgetrc".text = "";
    caramelmint.home.extraOptions = {

      programs = {
        nix-index-database.comma.enable = true;
        # https://github.com/eth-p/bat-extras
        btop.enable = true;
        # TODO: Make a module that includes all my main terminal workflows configured
        bat.enable = true;
        fzf.enable = true;
        zoxide = {
          enable = true;
          enableFishIntegration = true;
        };

        atuin = {
          enable = true;
          enableFishIntegration = true;
          settings = {
            auto_sync = true;
            sync_frequency = "5m";
            sync_address = "https://api.atuin.sh";
            inline_height = 15;
            enter_accept = false;
            keymap_mode = "vim-insert";
            keymap_cursor = {
              emacs = "blink-block";
              vim_insert = "blink-bar";
              vim_normal = "steady-block";
            };
          };
        };

        lsd = {
          enable = true;
          enableAliases = true;
        };

        lf.enable = true;

        less.enable = true;

        broot.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      fzf
      killall
      unzip
      file
      jq
      jqp
      clac
      wget
      trashy

      # Basic text editor
      nano
      micro

      # UNIX utils
      usbutils
      bc
      entr
      glances
      progress
      lsof
      p7zip
      gzip
      fd
      pv
      du-dust
      parallel-disk-usage
      dua
      gawk
      strace
      lurk # Rust alternative to strace
      tree
      ripgrep
      ripgrep-all
      rsync
      gnused
      killall
      bind # https://releases.nixos.org/nix-dev/2015-September/018037.html
    ];
  };
}
