{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.user;
in {
  options.caramelmint.user = with types; {
    name = mkOpt str "hfahmi" "The name to use for the user account.";
    fullName = mkOpt str "Hazem Fahmi" "The full name of the user.";
    email = mkOpt str "hzmmohamed@gmail.com" "The email of the user.";
    initialPassword = mkOpt str "password"
      "The initial password to use when the user is first created.";
    prompt-init = mkBoolOpt true
      "Whether or not to show an initial message when opening a new shell.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions =
      mkOpt attrs { } (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";

      shell = pkgs.fish;

      # Arbitrary user ID to use for the user. Since I only
      # have a single user on my machines this won't ever collide.
      # However, if you add multiple users you'll need to change this
      # so each user has their own unique uid (or leave it out for the
      # system to select).
      uid = 1000;

      extraGroups = [ ] ++ cfg.extraGroups;
    } // cfg.extraOptions;

    caramelmint = {
      mail = enabled;
      cli-apps = {
        fish = enabled;
        shell-history = enabled;
      };
      services = { blueman = enabled; };
    };

    caramelmint.home = {
      file = {
        "Downloads/.keep".text = "";
        "work/.keep".text = "";
      };

      extraOptions = {
        programs = {
          starship = {
            enable = true;
            settings = {
              character = {
                success_symbol = "[➜](bold green)";
                error_symbol = "[✗](bold red) ";
                vicmd_symbol = "[](bold blue) ";
              };
            };
          };
        };
      };
    };
  };
}
