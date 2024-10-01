{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.tools.adb;
in {
  options.caramelmint.tools.adb = with types; {
    enable = mkBoolOpt false "Whether or not to enable ADB.";
  };

  config = mkIf cfg.enable {
    programs.adb.enable = true;
    caramelmint.user.extraGroups = [ "adbusers" ];
  };
}
