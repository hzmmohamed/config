{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.desktop.addons.gammastep;
in {
  options.caramelmint.desktop.addons.gammastep = with types; {
    enable =
      mkBoolOpt false "Whether or not to install and configure gamma step.";
  };

  config = mkIf cfg.enable {
    services.gammastep = {
      #https://nixos.wiki/wiki/gamma-step
      enable = true;
      tray = true;
      dawnTime = "05:00";
      duskTime = "19:00";
    };

    services.darkman = {
      enable = true;
      darkModeScripts = {
        gtk-theme = ''
          ${pkgs.dconf}/bin/dconf write \
              /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        '';
        vscodium-theme = ''
          ${pkgs.gnused}/bin/sed -i -e 's/"workbench.colorTheme": ".*"/"workbench.colorTheme": "Catppuccin Mocha"/g' "$HOME/.config/VSCodium/User/settings.json"

        '';
      };
      lightModeScripts = {
        gtk-theme = ''
          ${pkgs.dconf}/bin/dconf write \
              /org/gnome/desktop/interface/color-scheme "'prefer-light'"
        '';
        vscodium-theme = ''
          ${pkgs.gnused}/bin/sed -i -e 's/"workbench.colorTheme": ".*"/"workbench.colorTheme": "Catppuccin Latte"/g' "$HOME/.config/VSCodium/User/settings.json"

        '';

      };
    };

  };
}
