{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.suites.desktop;
in {
  options.caramelmint.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    environment.systemPackages = with pkgs; [ appimage-run ];
    services.logind.extraConfig = ''
      HandlePowerKey=suspend
      IdleAction=suspend
      IdleActionSec=1m
    '';

    # screen locker
    programs.xss-lock.enable = true;

    # Necessary for udiskie
    services.udisks2 = enabled;

    caramelmint = {

      home.extraOptions = { services.udiskie = enabled; };
      desktop = {
        sway = enabled;
        addons = { xdg-portal = enabled; };
      };
    };
  };
}
