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
    
  };
}
