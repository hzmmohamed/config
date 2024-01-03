{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.tools.activity-watch;
in {
  options.caramelmint.tools.activity-watch = with types; {
    enable = mkBoolOpt false "Whether or not to enable Activity Watcher.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {
      home.packages = with pkgs; [
        activitywatch
      ];
      # Activity watch

      systemd.user.services = {
        aw-server = {
          Unit = {
            Description = "Activity Watch - Server";
            After = ["graphical-session-pre.target"];
            PartOf = ["graphical-session.target"];
          };

          Service = {
            ExecStart = "${pkgs.activitywatch}/bin/aw-server";
          };

          Install = {WantedBy = ["graphical-session.target"];};
        };

        aw-watcher-window-wayland = {
          Unit = {
            Description = "Activity Watch Window Watcher for Wayland";
            After = ["graphical-session-pre.target"];
            PartOf = ["graphical-session.target"];
          };

          Service = {
            ExecStart = "${pkgs.caramelmint.aw-watcher-window-wayland}/bin/aw-watcher-window-wayland";
          };

          Install = {WantedBy = ["graphical-session.target"];};
        };
      };
    };
  };
}
