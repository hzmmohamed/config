{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.desktop.addons.rbw;
in {
  options.caramelmint.desktop.addons.rbw = with types; {
    enable = mkBoolOpt false
      "Whether or not to install and configure rbw for brightness management.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {

      programs.rbw = {
        enable = true;
        settings = {
          email = "hzmmohamed@gmail.com";
          pinentry = pkgs.pinentry-qt;
        };
      };

      home.packages = with pkgs; [ rofi-rbw-wayland ];

    };
  };
}
