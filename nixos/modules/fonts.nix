{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
      font-awesome
      kawkab-mono-font
      roboto
      roboto-mono

      fira-code

      jetbrains-mono
      victor-mono

      noto-fonts-extra
      noto-fonts-emoji

      # Meslo Nerd fonts package contains all the needed glyphs for the tide prompt
      meslo-lgs-nf
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["FreeSerif"];
        sansSerif = ["Roboto"];
        monospace = ["JetBrainsMono"];
      };
    };
  };
}
