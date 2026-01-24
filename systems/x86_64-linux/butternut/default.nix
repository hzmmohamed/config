{ pkgs, config, lib, channel, ... }:
with lib;
with lib.caramelmint; {
  imports = [ ./disk-config.nix ./hardware.nix ];

  # Replaced nix-serve with the more performant nix-serve-ng
  # Ref: https://github.com/aristanetworks/nix-serve-ng?tab=readme-ov-file#variant-a
  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    openFirewall = true;
    secretKeyFile = "/run/secrets/nix-serve-secret-key";
  };
  sops.secrets."nix-serve-secret-key" = {
    sopsFile = ./nix-serve/secrets.yaml;
  };

  # services.actual = enabled;

  # caramelmint.nix.extra-substituters = {
  #   "http://maple:5000" = {
  #     # The public key corresponding to the secret key configured for maple's cache
  #     key = "maple:jZJsItwJA6yR/faOnUm+r+mMAEmUDWtu31Pp23MsNsM=";
  #   };
  # };

  services.openssh = {
    enable = true;
    ports = [ 7654 ]; # Change this to your preferred port
    settings = {
      PasswordAuthentication = true; # Recommended for security
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  # Ensure the custom port is open in the firewall
  networking.firewall.allowedTCPPorts = [ 2222 ];

  programs.wayvnc.enable = true;

  caramelmint = {
    suites = {
      common = enabled;
      desktop = enabled;
      development = enabled;
      office = enabled;
      design = enabled;
      media = enabled;
      # games = enabled;
      music-production = enabled;
      maker-tools = enabled;
      # ai = enabled;
    };

    theme = {
      desktop = enabled;
      boot = { enable = false; };
    };

    # hardware = { nvidia = enabled; };
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

  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # WiFi is typically unused on the desktop. Enable this service
  # if it's no longer only using a wired connection.
  # systemd.services.network-addresses-wlp41s0.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
