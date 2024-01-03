{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.desktop.addons.gammastep;
in {
  options.caramelmint.desktop.addons.gammastep = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure gamma step.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {
      services.gammastep = {
        #https://nixos.wiki/wiki/gamma-step
        enable = true;
        tray = true;
        dawnTime = "05:00";
        duskTime = "19:00";
      };
    };
  };
}
