{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.suites.games;
in {
  options.caramelmint.suites.games = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common configuration for games.";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };

    # TODO: Replicate this in common desktop configuration
    hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
        mesa.drivers
        intel-ocl
        intel-media-driver
        nvidia-vaapi-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        dxvk
      ];
    };

    environment.systemPackages = with pkgs; [
      # Lutris
      lutris
      # Needed for some installers like League of Legends
      openssl
      gnome.zenity

      prismlauncher

      protontricks
    ];

    caramelmint.cli-apps.wine = enabled;
  };
}
