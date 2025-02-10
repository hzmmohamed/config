{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.caramelmint; let
  cfg = config.caramelmint.tools.activity-watch;
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
            package = pkgs.activitywatch;
            settings = {
              timeout = 300;
              poll_time = 2;
            };
          };
          # Reports both window and afk status to separate buckets
          awatcher = {
            name = "awatcher";
            package = pkgs.awatcher;
          };
        };
      };
    };
  };
}
