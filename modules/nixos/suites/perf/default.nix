{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.suites.perf;
in {
  options.caramelmint.suites.perf = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common configuration for maker tools.";
  };

  config = mkIf cfg.enable {
    services.auto-cpufreq = enabled;
    environment.systemPackages = with pkgs; [
      powertop

      # HW Monitoring tools
      smartmontools
      intel-gpu-tools
      lm_sensors
      pciutils
      ethtool
      iperf
    ];
  };
}
