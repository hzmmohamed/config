{ inputs, outputs, lib, config, pkgs, ... }: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
    targets = {
      vscode.enable = true;
      zellij.enable = true;
      fish.enable = false;
      waybar = {
        enableCenterBackColors = true;
        enableRightBackColors = true;
        enableLeftBackColors = true;
      };
    };
    fonts =
      let
        nf = pkgs.nerdfonts.override {
          fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" "Inconsolata" ];
        };
      in
      {
        sansSerif = {
          package = pkgs.roboto;
          name = "Roboto";
        };

        serif = config.stylix.fonts.sansSerif;

        monospace = {
          package = nf;
          name = "JetBrainsMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
  };
}
