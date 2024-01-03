{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.desktop.addons.xdg-portal;
in {
  options.caramelmint.desktop.addons.xdg-portal = with types; {
    enable = mkBoolOpt false "Whether or not to add support for xdg portal.";
  };

  config = mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        config.common.default = "*";

        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
          xdg-desktop-portal-kde
        ];
      };
    };
    caramelmint.home.extraOptions = {
      xdg.configFile."xdg-desktop-portal-wlr/config".text = ''
        [screencast]
        output_name=
        max_fps=30
        chooser_cmd=${pkgs.slurp}/bin/slurp -f %o -or
        chooser_type=simple
      '';
    };
  };
}
