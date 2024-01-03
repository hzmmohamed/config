{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.apps.zoom;
in {
  options.caramelmint.apps.zoom = with types; {
    enable = mkBoolOpt false "Whether to enable Zoom.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {
      home.packages = with pkgs; [
        zoom
      ];
    };
  };
}
