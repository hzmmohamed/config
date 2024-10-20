{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.tools.activity-watch;
in {
  options.caramelmint.tools.activity-watch = with types; {
    enable = mkBoolOpt false "Whether or not to enable Activity Watcher.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {

      services.activitywatch = {
        enable = true;
        watchers = {
          aw-watcher-afk = {
            name = "aw-watcher-afk";
            package = pkgs.aw-watcher-afk;
          };
          aw-watcher-window-wayland = {
            name = "aw-watcher-window-wayland";
            package = pkgs.aw-watcher-window-wayland;
          };
        };
      };

    };
  };
}
