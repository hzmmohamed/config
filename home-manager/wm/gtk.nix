{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    # theme = {
    #   name = "Catppuccin-Mocha-BL-LB";
    #   # package = pkgs.cattpuccin-mocha-gtk;
    # };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    # font.name = "JetbrainsMono nerd font";
    # font.size = 11;
    # cursorTheme = {
    #   name = "Catppuccin-Latte-Dark";
    # };
  };
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 17;
  };

  home.sessionVariables = {
    GTK_USE_PORTAL = 1;
    # GTK_THEME = "Catppuccin-Mocha-BL-LB";
  };
}
