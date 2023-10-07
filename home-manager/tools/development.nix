{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # dev
    gibo
    alejandra
    jqp
    distrobox
    lazydocker
    dbeaver
    # Removed many of the tools here to make iterating on the system flake faster. Plus make the system lighter to begin with, adding specific tools for specific projects.
    sway-launcher-desktop
    sqlfluff
    trunk-io
  ];

  programs = {lazygit = {enable = true;};};
}
