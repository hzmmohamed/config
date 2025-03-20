{ lib, pkgs, config, osConfig ? { }, format ? "unknown", inputs, ... }:
with lib;
with lib.caramelmint; {
  # colorScheme = inputs.nix-colors.colorSchemes.gruvbox-light-medium;
  caramelmint = {
    tools = {
      zellij = enabled;
      yazi = enabled;
      freetube = enabled;
    };
    desktop = {
      addons = {
        alacritty = enabled;
        # foot = enabled;
        gammastep = enabled;
        mako = enabled;
        wofi = enabled;
        kanshi = enabled;
        waybar = enabled;
      };
    };
  };
}
