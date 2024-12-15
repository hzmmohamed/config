{ pkgs, config, lib, channel, ... }:
with lib;
with lib.caramelmint; {
  imports = [ ./hardware.nix ./boot.nix ];

  # Replace nix-serve with the more performant nix-serve-ng
  # https://github.com/aristanetworks/nix-serve-ng?tab=readme-ov-file#variant-a
  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    openFirewall = true;
    secretKeyFile =
      "/home/hfahmi/personal/config/systems/x86_64-linux/butternut/secret-key-file";
  };

  caramelmint = {
    suites = {
      common = enabled;
      desktop = enabled;
      development = enabled;
      office = enabled;
      design = enabled;
      media = enabled;
      games = enabled;
      music-production = enabled;
      maker-tools = enabled;
      ai = enabled;
    };

    hardware = { nvidia = enabled; };
    system.power = enabled;
  };
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
