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
    services.logind.extraConfig = ''
      HandlePowerKey=suspend
      IdleAction=suspend
      IdleActionSec=1m
    '';

    # screen locker
    programs.xss-lock.enable = true;

    # Necessary for udiskie
    services.udisks2 = enabled;

    services.glance = { enable = true; };

    environment.systemPackages = with pkgs; [
      appimage-run

      # Miracast
      gnome-network-displays
    ];
    networking.firewall.allowedTCPPorts = [ 7236 7250 ];
    networking.firewall.allowedUDPPorts = [ 7236 5353 ];

    caramelmint = {

      home.extraOptions = {
        home.packages = with pkgs; [ glance ];
        services.udiskie = enabled;
      };
      desktop = {
        sway = enabled;
        addons = { xdg-portal = enabled; };
      };
    };
  };
}
