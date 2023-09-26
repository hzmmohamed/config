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
    gcc
    kind
    awscli2
    ctlptl
    dive
    tilt
    docker-compose
    python311
    python311Packages.pip
    python310Packages.fn
    poetry
    alejandra
    jqp
    postman
    nil # LSP for Nix
    dbeaver
    xterm
    distrobox
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
