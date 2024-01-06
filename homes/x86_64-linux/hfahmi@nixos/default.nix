{
  lib,
  pkgs,
  config,
  osConfig ? {},
  format ? "unknown",
  inputs,
  ...
}:
with lib;
with lib.plusultra; {
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-light-hard;
  caramelmint = {
    desktop = {
      addons = {
        alacritty = enabled;
        gammastep = enabled;
        mako = enabled;
        wofi = enabled;
        kanshi = enabled;
        waybar = enabled;
      };
    };
  };
}
