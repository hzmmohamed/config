{ lib, pkgs, config, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.services.syncthing;
in {
  options.caramelmint.services.syncthing = with types; {
    enable = mkBoolOpt false "Whether or not to configure syncthing";
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
          "caramelmint.services.syncthing.myCredentials.key must be set";
      }
      {
        assertion = cfg.myCredentials.cert != "";
        message =
          "caramelmint.services.syncthing.myCredentials.cert must be set";
      }
    ];

    services.syncthing = {
      enable = true;
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
            id = "SJ4NR4M-QBWK5ZD-OILYP7A-DMZPT4B-OX4I47D-GBKHMGT-3NXJNID-4Q42EA6";
          };
          "maple" = {
            id =
              "H7H47TV-XI7EQDB-U4RAQWU-BYMDKVT-6HNATQP-EDELRE7-35GLDGH-BKAUBAW";
          };
        };
        # folders = {
        #   "Documents" = {
        #     path = "/home/myusername/Documents";
        #     devices = [ "device1" "device2" ];
        #   };
        #   "Example" = {
        #     path = "/home/myusername/Example";
        #     devices = [ "device1" ];
        #     # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
        #     ignorePerms = false;
        #   };
        # };
      };

    };
  };
}
