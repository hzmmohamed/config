{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.tools.espanso;
in {
  options.caramelmint.tools.espanso = with types; {
    enable = mkBoolOpt false "Whether or not to enable Espanso.";
  };

  config = mkIf cfg.enable {
    services.espanso = {
      enable = true;
      # TODO: Add more config. Also I reckon that I might need to change the default package to the wayland version here https://search.nixos.org/packages?channel=23.05&show=espanso-wayland&from=0&size=50&sort=relevance&type=packages&query=espanso
    };
  };
}
