{ pkgs, config, lib, channel, ... }:
with lib;
with lib.caramelmint; {
  imports = [ ./disk-config.nix ];
  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMhxcLHsjikNd2JG4vRp55lEaJpUZNYS3TdjQ9aIii9T hzmmohamed@gmail.com"
  ];

  caramelmint.nix.extra-substituters = {
    "http://butternut:5000" = {
      # Any value for the key
      key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    };
  };

  caramelmint = {
    suites = {
      common = enabled;
      # desktop = enabled;
      # development = enabled;
      # office = enabled;
      # design = enabled;
      # media = enabled;
      # games = enabled;
      # music-production = enabled;
      # maker-tools = enabled;
    };

    hardware = { nvidia = enabled; };
    system.power = enabled;
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
