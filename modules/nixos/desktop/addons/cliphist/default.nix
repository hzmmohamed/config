{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.desktop.addons.cliphist;
in {
  options.caramelmint.desktop.addons.cliphist = with types; {
    enable =
      mkBoolOpt false "Whether or not to install and configure cliphist.";
  };

  config = mkIf cfg.enable {
    # caramelmint.desktop.addons.wofi = enabled;
    caramelmint.home.extraOptions = {
      services.cliphist = { enable = true; };
      home.packages = with pkgs; [ wl-clipboard ];
      wayland.windowManager.sway.config.keycodebindings."Mod1+Shift+50" = # Mod1+Shift+p
        "exec cliphist list | wofi -S dmenu | cliphist decode | wl-copy";
    };
  };
}
