{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.desktop.addons.kanshi;
in {
  options.caramelmint.desktop.addons.kanshi = with types; {
    enable =
      mkBoolOpt false "Whether to enable Kanshi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    # xdg.configFile."kanshi/config".source = ./config;

    services.kanshi = {
      enable = true;
      profiles = {
        laptop = {
          outputs = [
            {
              mode = "1920x1080@60Hz";
              scale = 1.2;
              position = "0,0";
              status = "enable";
              criteria = "eDP-1";
            }
          ];
        };
      };
    };

    # # configuring kanshi
    # systemd.user.services.kanshi = {
    #   Unit = {
    #     Description = "Kanshi output autoconfig ";
    #     WantedBy = ["graphical-session.target"];
    #     PartOf = ["graphical-session.target"];
    #   };

    #   Service = {
    #     ExecCondition = ''
    #       ${pkgs.bash}/bin/bash -c '[ -n "$WAYLAND_DISPLAY" ]'
    #     '';

    #     ExecStart = ''
    #       ${pkgs.kanshi}/bin/kanshi
    #     '';

    #     RestartSec = 5;
    #     Restart = "always";
    #   };
    # };
  };
}
