{ pkgs, config, lib, channel, ... }:
with lib;
with lib.caramelmint; {
  imports = [ ./disk-config.nix ./hardware.nix ];
  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMhxcLHsjikNd2JG4vRp55lEaJpUZNYS3TdjQ9aIii9T hzmmohamed@gmail.com"
  ];
  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    openFirewall = true;
    secretKeyFile = "/run/secrets/nix-serve-secret-key";
  };
  sops.secrets."nix-serve-secret-key" = {
    sopsFile = ./nix-serve/secrets.yaml;
  };

  # caramelmint.nix.extra-substituters = {
  #   "http://butternut:5000" = {
  #     # Any value for the key
  #     key = "butternut:uXXUBdRO9KP5DDdmrN80171HDGjqRB5zsey1I7Db8XM=";
  #   };
  # };

  caramelmint = {
    suites = {
      common = enabled;
      desktop = enabled;
      development = enabled;
      office = enabled;
      # design = enabled;
      media = enabled;
      # games = enabled;
      # music-production = enabled;
      maker-tools = enabled;
    };

    hardware = { nvidia = enabled; };
    system.power = enabled;
  };

  sops.secrets."syncthing/key" = {
    sopsFile = ./syncthing/secrets.yaml;
    owner = "syncthing";
    mode = "0400";
  };

  sops.secrets."syncthing/cert" = {
    sopsFile = ./syncthing/secrets.yaml;
    owner = "syncthing";
    mode = "0400";
  };
  services.syncthing = {
    enable = true;
    user = "syncthing";
    key = "/run/secrets/syncthing/key";
    cert = "/run/secrets/syncthing/cert";
  };


  services.tlp.settings.CPU_ENERGY_PERF_POLICY_ON_BAT = lib.mkForce "performance";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
