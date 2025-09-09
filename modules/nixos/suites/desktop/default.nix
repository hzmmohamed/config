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

    # services.whoogle-search = enabled;

    environment.systemPackages = with pkgs; [
      appimage-run

      # Miracast
      gnome-network-displays
    ];
    networking.firewall.allowedTCPPorts = [ 7236 7250 ];
    networking.firewall.allowedUDPPorts = [ 7236 5353 ];
    services.earlyoom = {
      enable = true;
      enableNotifications = true;
    };

    caramelmint = {
      home.extraOptions = {
        home.packages = with pkgs; [
          # Comms
          vesktop
          element-desktop

          glance
          wifi-qr
          nwg-displays
          wl-screenrec
          # TODO: Move color picker to design suite and add global shortcut to get it any time.
          wl-color-picker
        ];
        services.udiskie = enabled;
      };
      desktop = {
        sway = enabled;
        addons = { xdg-portal = enabled; };
      };
    };
  };
}
