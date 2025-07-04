{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.desktop.addons.xdg-portal;
in {
  options.caramelmint.desktop.addons.xdg-portal = with types; {
    enable = mkBoolOpt false "Whether or not to add support for xdg portal.";
  };

  config = mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        config.common.default = "wlr";

        extraPortals = with pkgs; [
          # unstable.xdg-desktop-portal-termfilechooser
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
          kdePackages.xdg-desktop-portal-kde
        ];
      };
    };
    caramelmint.home.extraOptions = {
      home.packages = with pkgs; [ ashpd-demo ];

      # xdg.configFile."xdg-desktop-portal-wlr/config".text = ''
      #   [screencast]
      #   output_name=
      #   max_fps=30
      #   chooser_cmd=${pkgs.slurp}/bin/slurp -f %o -or
      #   chooser_type=simple
      # '';
    };
  };
}
