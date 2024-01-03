{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.desktop.addons.waybar;
in {
  options.caramelmint.desktop.addons.waybar = with types; {
    enable =
      mkBoolOpt false "Whether to enable Waybar in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [waybar];

    # TODO: Will leave jake's config and add mine later.
    caramelmint.home.configFile."waybar/config".source = ./config;
    caramelmint.home.configFile."waybar/style.css".source = ./style.css;
  };
}
