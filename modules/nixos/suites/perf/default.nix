{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.suites.perf;
in {
  options.caramelmint.suites.perf = with types; {
    enable =
      mkBoolOpt false
      "Whether or not to enable common configuration for maker tools.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      powertop

      # HW Monitoring tools
      smartmontools
      intel-gpu-tools
      lm_sensors
    ];
  };
}
