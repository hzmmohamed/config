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
    theme = enabled;
    hardware = { nvidia = enabled; };
    system.power = enabled;

    # Start Syncthing Config
    services.unified-syncthing-config = {
      enable = true;
      myCredentials = {
        key = config.sops.secrets."syncthing/key".path;
        cert = config.sops.secrets."syncthing/cert".path;
      };

    };
  };
  sops.secrets."syncthing/key" = {
    sopsFile = ./syncthing/secrets.yaml;
    owner = config.caramelmint.user.name;
    group = config.users.users.${config.caramelmint.user.name}.group;
    mode = "0400";
    restartUnits = [ "syncthing.service" ];
  };

  sops.secrets."syncthing/cert" = {
    sopsFile = ./syncthing/secrets.yaml;
    owner = config.caramelmint.user.name;
    group = config.users.users.${config.caramelmint.user.name}.group;
    mode = "0400";
    restartUnits = [ "syncthing.service" ];
  };

  # End Syncthing Config
  services.tlp.settings.CPU_ENERGY_PERF_POLICY_ON_BAT =
    lib.mkForce "performance";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
