{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.hardware.touchpad;
in {
  options.caramelmint.hardware.touchpad = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable and configure touchpad support.";
  };

  config = mkIf cfg.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        naturalScrolling = false;
        middleEmulation = true;

        # TODO: Research this option to make scrolling better on the ASUS TUF dashboard https://wayland.freedesktop.org/libinput/doc/latest/configuration.html
        # accelSpeed =
      };
    };
  };
}
