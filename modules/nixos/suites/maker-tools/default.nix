{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.suites.maker-tools;
in {
  options.caramelmint.suites.maker-tools = with types; {
    enable =
      mkBoolOpt false
      "Whether or not to enable common configuration for maker tools.";
  };

  config = mkIf cfg.enable {
    caramelmint = {
      tools = {
        git = enabled;
      };

      home.extraOptions = {
        home.packages = with pkgs; [
          freecad
          kicad
          gimp
          inkscape
        ];
      };
    };
  };
}
