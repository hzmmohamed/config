{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.system.fonts;
in {
  options.caramelmint.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [ font-manager ];

    fonts.fontconfig = {
      defaultFonts = {
        serif = [ "FreeSerif" ];
        sansSerif = [ "Roboto" ];
        monospace = [ "JetBrainsMono" "Kawkab Mono" ];
      };
    };

    fonts.packages = with pkgs;
      [
        noto-fonts
        noto-fonts-extra
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        font-awesome
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

        kawkab-mono-font

        roboto

        jetbrains-mono

        # TODO: Move these fonts to other modules where they are relevant. e.g. Design fonts, etc.
        roboto-mono

        victor-mono
        jost
        open-sans
        cabin
        junction-font

        # Meslo Nerd fonts package contains all the needed glyphs for the tide prompt
        meslo-lgs-nf
      ] ++ cfg.fonts;
  };
}
