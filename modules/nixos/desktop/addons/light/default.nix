{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.desktop.addons.light;
in {
  options.caramelmint.desktop.addons.light = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure light for brightness management.";
  };

  config = mkIf cfg.enable {
    programs.light.enable = true;
    caramelmint.user.extraGroups = ["video"];
  };
}
