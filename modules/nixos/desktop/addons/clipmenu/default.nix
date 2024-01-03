{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.desktop.addons.clipmenu;
in {
  options.caramelmint.desktop.addons.clipmenu = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure clipmenu.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {
      services.clipmenu = {
        enable = true;
        launcher = "rofi";
      };
    };
  };
}
