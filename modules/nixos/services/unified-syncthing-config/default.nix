{ lib, pkgs, config, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.services.unified-syncthing-config;
in {
  options.caramelmint.services.unified-syncthing-config = with types; {
    enable = mkBoolOpt false "Whether or not to configure syncthing";
    systemd-user = mkOpt str "syncthing" "User for the syncthing service";
    myCredentials = {
      key = mkOpt str "" "The authentication key to use";
      cert = mkOpt str "" "The authentication key to use";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.myCredentials.key != "";
        message =
          "caramelmint.services.unified-syncthing-config.myCredentials.key must be set";
      }
      {
        assertion = cfg.myCredentials.cert != "";
        message =
          "caramelmint.services.unified-syncthing-config.myCredentials.cert must be set";
      }
    ];
    systemd.services.syncthing.environment.STNODEFAULTFOLDER =
      "true"; # Don't create default ~/Sync folder

    services.syncthing = {
      enable = true;
      user = config.caramelmint.user.name;
      group = config.users.users.${config.caramelmint.user.name}.group;
      dataDir = config.users.users.${config.caramelmint.user.name}.home;
      openDefaultPorts = true;
      settings.gui = {
        user = "hfahmi";
        password = "password";
      };
      key = cfg.myCredentials.key;
      cert = cfg.myCredentials.cert;
      settings = {
        devices = {
          "butternut" = {
            id =
              "SJ4NR4M-QBWK5ZD-OILYP7A-DMZPT4B-OX4I47D-GBKHMGT-3NXJNID-4Q42EA6";
          };
          "maple" = {
            id =
              "H7H47TV-XI7EQDB-U4RAQWU-BYMDKVT-6HNATQP-EDELRE7-35GLDGH-BKAUBAW";
          };
        };
        folders = {
          "zotero-db" = {
            path = "${
                config.users.users.${config.caramelmint.user.name}.home
              }/Zotero";
            devices = [ "butternut" "maple" ];
            # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
            ignorePerms = false;
          };
          "zotero-attachments" = {
            path = "${
                config.users.users.${config.caramelmint.user.name}.home
              }/personal/zotero-attachments";
            devices = [ "butternut" "maple" ];
            # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
            ignorePerms = false;
          };
           "flower-choir" = {
            path = "${
                config.users.users.${config.caramelmint.user.name}.home
              }/personal/flower-choir";
            devices = [ "butternut" "maple" ];
            # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
            ignorePerms = false;
          };
        };
      };

    };
  };
}
