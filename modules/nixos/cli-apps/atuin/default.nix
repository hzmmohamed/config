{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.cli-apps.shell-history;
in {
  options.caramelmint.cli-apps.shell-history = with types; {
    enable = mkBoolOpt false "Whether or not to configure shell history.";
  };

  config = mkIf cfg.enable {
    sops.secrets.atuin_key = {
      sopsFile = ./secrets.yaml;
      owner = config.caramelmint.user.name;
      path = "~/.local/share/atuin/key";
    };
    caramelmint.secrets.enable = lib.mkForce true;
    caramelmint.home.extraOptions = {
      programs = {
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
      };
    };
  };
}

