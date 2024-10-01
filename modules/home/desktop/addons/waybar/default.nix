{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.desktop.addons.waybar;
in {
  options.caramelmint.desktop.addons.waybar = with types; {
    enable =
      mkBoolOpt false "Whether to enable Waybar in the desktop environment.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ waybar ];

    # TODO: Will leave jake's config and add mine later.
    xdg.configFile."waybar/config".source = ./config;
    xdg.configFile."waybar/style.css".source = ./style.css;
  };
}
