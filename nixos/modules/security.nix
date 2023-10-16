{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # The current NixOS module causes this error on starting the Clamav daemon for the first time
  # https://discourse.nixos.org/t/how-to-use-clamav-in-nixos/19782/3
  # Enable the ClamAV service and keep the database up to date
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };
}
