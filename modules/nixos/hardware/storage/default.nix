{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.hardware.storage;
in {
  options.caramelmint.hardware.storage = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable support for extra storage devices.";
    autoMount = mkBoolOpt true "Whether or not to enable automounting devices.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ntfs3g fuseiso smartmontools ];
    services.smartd = {
      enable = true;
      notifications.systembus-notify.enable = true;
    };
    caramelmint.home.extraOptions = {
      services.udiskie = mkIf cfg.autoMount {
        enable = true;
        tray = "always";
      };
    };
  };
}
