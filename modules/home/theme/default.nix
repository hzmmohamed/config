{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.theme;
in {
  options.caramelmint.theme = with types; {
    enable = mkBoolOpt false "Whether or not to enable catppuccin theme.";
  };

  config = mkIf cfg.enable { catppuccin = { enable = true; }; };
}
