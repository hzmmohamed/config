{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # productivity
    zoom-us
    lf
    pcmanfm
    zotero
    libreoffice
    qgis
    libsForQt5.kgpg
    ktorrent
    anytype
    trashy
    pdfgrep

    # design
    figma-linux
    freecad
    kicad
    gimp
    inkscape

    fontfor
    fontforge
    font-manager

    # media
    vlc
    digikam
    ytfzf
    ffmpeg_5
    handbrake
    mpv
    pavucontrol

    # UNIX utils
    entr
    wget
    glances
    progress
    p7zip
    gzip
    fd
    pv
    gawk
    strace
    lurk # Rust alternative to strace
    tree
    ripgrep
    ripgrep-all
    rsync
    gnused
    killall
    bind # https://releases.nixos.org/nix-dev/2015-September/018037.html
  ];
}
