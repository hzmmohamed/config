{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.cli-apps.wine;
in {
  options.caramelmint.cli-apps.wine = with types; {
    enable = mkBoolOpt false "Whether or not to enable Wine.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wineWowPackages.stable
      winetricks
      # winePackages.unstable
      # wine64Packages.unstable
    ];
  };
}
