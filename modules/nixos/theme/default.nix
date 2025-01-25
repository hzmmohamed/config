{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.theme;
in {
  options.caramelmint.theme = with types; {
    enable = mkBoolOpt false "Whether or not to enable catppuccin theme.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {
      catppuccin = {
        enable = true;
        flavor = "latte";
        accent = "green";
      };
    };

    # stylix = {
    #   enable = true;
    #   image = ./wp8457216-solarpunk-wallpapers.jpg;
    #   polarity = "light";
    #   base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/measured-light.yaml";
    # };
  };
}
