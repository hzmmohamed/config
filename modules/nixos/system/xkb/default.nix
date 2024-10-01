{ options, config, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.system.xkb;
in {
  options.caramelmint.system.xkb = with types; {
    enable = mkBoolOpt false "Whether or not to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      layout = "us,ara";

      # xkbOptions = "caps:escape";
    };
  };
}
