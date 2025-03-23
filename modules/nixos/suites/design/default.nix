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
    # TODO: Figure out why the touchpad driver conflicts with this driver. Otherwise, it works perfectly with the Deco 01
    # I also tried libsForQt5.xp-pen-deco-01-v2-driver and the build failed to download the driver files from XP Pen
    # hardware.opentabletdriver = enabled;
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
