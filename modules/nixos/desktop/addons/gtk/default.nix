{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.caramelmint; let
  cfg = config.caramelmint.desktop.addons.gtk;
  gdmCfg = config.services.xserver.displayManager.gdm;
in {
  options.caramelmint.desktop.addons.gtk = with types; {
    enable = mkBoolOpt false "Whether to customize GTK and apply themes.";
    # theme = {
    #   name =
    #     mkOpt str "Catppuccin-Macchiato-Compact-Pink-Dark"
    #     "The name of the GTK theme to apply.";
    #   pkg = mkOpt package pkgs.catppuccin-gtk.override {
    #     accents = ["pink"];
    #     size = "compact";
    #     tweaks = ["rimless"];
    #     variant = "latte";
    #   } "The package to use for the theme.";
    # };

    cursor = {
      name =
        mkOpt str "Bibata-Modern-Classic"
        "The name of the cursor theme to apply.";
      pkg = mkOpt package pkgs.bibata-cursors "The package to use for the cursor theme.";
    };
    icon = {
      name =
        mkOpt str "Papirus"
        "The name of the icon theme to apply.";
      pkg = mkOpt package pkgs.papirus-icon-theme "The package to use for the icon theme.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.icon.pkg
      cfg.cursor.pkg
    ];

    environment.sessionVariables = {
      XCURSOR_THEME = cfg.cursor.name;
    };

    programs.dconf = enabled;

    caramelmint.home.extraOptions = {
      home.sessionVariables = {
        # GTK_THEME = "Catppuccin-Mocha-BL-LB";
      };

      gtk = {
        enable = true;

        # theme = {
        #   name = cfg.theme.name;
        #   package = cfg.theme.pkg;
        # };
        theme = {
          name = "Catppuccin-Latte-Compact-Pink-Light";
          package = pkgs.catppuccin-gtk.override {
            accents = ["pink"];
            size = "compact";
            tweaks = ["rimless"];
            variant = "macchiato";
          };
        };

        cursorTheme = {
          name = cfg.cursor.name;
          package = cfg.cursor.pkg;
        };

        iconTheme = {
          name = cfg.icon.name;
          package = cfg.icon.pkg;
        };
      };
    };
  };
}
