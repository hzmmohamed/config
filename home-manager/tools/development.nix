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

  # xdg.configFile.direnv = {
  #   text = ''
  #     [global]
  #     load_dotenv=true
  #   '';
  #   target = "direnv/direnv.toml";
  # };
}
