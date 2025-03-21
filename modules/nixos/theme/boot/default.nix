{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.theme.boot;
in {
  options.caramelmint.theme.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable catppuccin theme.";
  };

  config = mkIf cfg.enable {

    boot.plymouth = {
      enable = true;
      themePackages = [ pkgs.plymouth-matrix-theme ];
      theme = "matrix";
    };

    # stylix = {
    #   enable = true;
    #   image = ./wp8457216-solarpunk-wallpapers.jpg;
    #   polarity = "light";
    #   base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/measured-light.yaml";
    # };
  };
}
