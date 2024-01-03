{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.tools.direnv;
in {
  options.caramelmint.tools.direnv = with types; {
    enable = mkBoolOpt false "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {
      programs.direnv = {
        enable = true;
        nix-direnv = enabled;
      };
    };
  };
}
