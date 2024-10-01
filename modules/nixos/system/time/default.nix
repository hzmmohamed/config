{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.system.time;
in {
  options.caramelmint.system.time = with types; {
    enable =
      mkBoolOpt false "Whether or not to configure timezone information.";
  };

  # TODO: This module doesn't make sense. Just more code to maintain. Eitherway it's just one line in the host config.
  config = mkIf cfg.enable { time.timeZone = "Africa/Cairo"; };
}
