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

    # Ref: https://github.com/lutris/docs/blob/master/HowToEsync.md
    security.pam.loginLimits = [{
      domain = "hfahmi";
      item = "nofile";
      type = "hard";
      value = "524288";
    }];
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };

    programs.gamemode = enabled;

    # Configure wired XBox Controller
    hardware.xone = enabled;

    # Configure wireless bluetooth controller (Failed attempt)
    # Refs: 
    # https://www.reddit.com/r/linux_gaming/comments/smxqm2/how_to_use_xpadneo_with_an_xbox_series_controller/

    # hardware.bluetooth.settings = {
    #   General = {
    #     Privacy = "device";
    #     JustWorksRepairing = "always";
    #     Class = "0x000100";
    #     FastConnectable = true;
    #     # ControllerMode = "bredr";
    #   };

    #   LE = {
    #     MinConnectionInterval = 7;
    #     MaxConnectionInterval = 9;
    #     ConnectionLatency = 0;
    #   };

    #   GATT = {
    #     ReconnectIntervals = "1,1,2,3,5,8,13,21,34,55";
    #     AutoEnable = true;
    #   };
    # };

    # TODO: Replicate this in common desktop configuration
    hardware.graphics = {
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

      evtest-qt # GUI Controller tester

      # Needed for some installers like League of Legends
      openssl
      zenity

      mangohud
    ];

    caramelmint.home.extraOptions = {
      home.packages = with pkgs; [
        # Lutris
        unstable.lutris

        # Proton
        protonup
        protontricks
      ];
      home.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS =
          "\\\${HOME}/.steam/root/compatibilitytools.d";
      };
    };

    caramelmint.cli-apps.wine = enabled;
  };
}
