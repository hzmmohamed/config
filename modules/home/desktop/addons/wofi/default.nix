{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.desktop.addons.wofi;
in {
  options.caramelmint.desktop.addons.wofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wofi wofi-emoji ];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors
    # xdg.configFile."foot/foot.ini".source = ./foot.ini;
    # xdg.configFile."wofi/config".source = ./config;
    # xdg.configFile."wofi/style.css".source = ./style.css;
  };
}
