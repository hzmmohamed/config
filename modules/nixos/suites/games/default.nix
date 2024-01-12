{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.suites.games;
in {
  options.caramelmint.suites.games = with types; {
    enable =
      mkBoolOpt false
      "Whether or not to enable common configuration for games.";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        mesa_drivers
        intel-ocl
        beignet
        intel-media-driver
        nvidia-vaapi-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
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
