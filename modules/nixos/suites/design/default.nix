{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.suites.design;
in {
  options.caramelmint.suites.design = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common configuration for maker tools.";
  };

  config = mkIf cfg.enable {
    caramelmint = {
      home.extraOptions = {
        home.packages = with pkgs; [
          # design
          figma-linux
          inkscape
          gimp

          fontfor
          fontforge
          font-manager
        ];
      };
    };
  };
}
