{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.caramelmint; let
  cfg = config.caramelmint.suites.desktop;
in {
  options.caramelmint.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    environment.systemPackages = with pkgs; [
      appimage-run
    ];
    caramelmint = {
      desktop = {
        sway = enabled;
        addons = {
          xdg-portal = enabled;
        };
      };
    };
  };
}
