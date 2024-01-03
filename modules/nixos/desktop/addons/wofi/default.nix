{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.desktop.addons.wofi;
in {
  options.caramelmint.desktop.addons.wofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [wofi wofi-emoji];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors
    # caramelmint.home.configFile."foot/foot.ini".source = ./foot.ini;
    caramelmint.home.configFile."wofi/config".source = ./config;
    caramelmint.home.configFile."wofi/style.css".source = ./style.css;
  };
}
