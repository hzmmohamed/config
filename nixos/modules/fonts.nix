{ inputs, outputs, lib, config, pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome

      kawkab-mono-font
      roboto
      roboto-mono

      victor-mono
      jost
      open-sans
      cabin
      junction-font
      noto-fonts-extra
      noto-fonts-emoji

      # Meslo Nerd fonts package contains all the needed glyphs for the tide prompt
      meslo-lgs-nf
    ];
  };
}
