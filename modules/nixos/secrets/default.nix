{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.secrets;
in {
  options.caramelmint.secrets = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    sops = { age.keyFile = "/home/hfahmi/.config/sops/age/keys.txt"; };
  };
}
