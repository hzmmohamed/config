{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.desktop.addons.foot;
in {
  options.caramelmint.desktop.addons.foot = with types; {
    enable = mkBoolOpt false "Whether to enable the foot terminal emulator.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.foot ];
    caramelmint.home.extraOptions = {
      programs.foot = {
        enable = true;
        settings = {
          colors = {
            foreground = "4c4f69"; # Text
            background = "eff1f5"; # Base
            regular0 = "5c5f77"; # Subtext 1
            regular1 = "d20f39"; # red
            regular2 = "40a02b"; # green
            regular3 = "df8e1d"; # yellow
            regular4 = "1e66f5"; # blue
            regular5 = "ea76cb"; # pink
            regular6 = "179299"; # teal
            regular7 = "acb0be"; # Surface 2
            bright0 = "6c6f85"; # Subtext 0
            bright1 = "d20f39"; # red
            bright2 = "40a02b"; # green
            bright3 = "df8e1d"; # yellow
            bright4 = "1e66f5"; # blue
            bright5 = "ea76cb"; # pink
            bright6 = "179299"; # teal
            bright7 = "bcc0cc"; # Surface 1
          };
        };
      };
    };
  };
}
