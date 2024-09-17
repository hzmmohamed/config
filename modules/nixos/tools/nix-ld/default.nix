{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.caramelmint; let
  cfg = config.caramelmint.tools.nix-ld;
in {
  options.caramelmint.tools.nix-ld = with types; {
    enable = mkBoolOpt false "Whether or not to enable nix-ld.";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
