{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.caramelmint; let
  cfg = config.caramelmint.hardware.networking;
in {
  options.caramelmint.hardware.networking = with types; {
    enable = mkBoolOpt false "Whether or not to enable networking support";

    # TODO: "Change this into vnstat.enable"
    enable-vnstat = mkBoolOpt false "Whether or not to enable recording data usage data.";
    hosts =
      mkOpt attrs {}
      (mdDoc "An attribute set to merge with `networking.hosts`");
  };

  config = mkIf cfg.enable {
    caramelmint.user.extraGroups = ["networkmanager"];

    networking = {
      hosts =
        {
          "127.0.0.1" = ["local.test"] ++ (cfg.hosts."127.0.0.1" or []);
        }
        // cfg.hosts;

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      # useDHCP = lib.mkDefault true;
      # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
      # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

      networkmanager = {
        enable = true;
        dhcp = "internal";
        # TODO: Make this configurable
        insertNameservers = ["8.8.8.8"];
      };
    };
    # TODO: Make sure that this conditional is working
    programs.nm-applet = mkIf config.caramelmint.desktop.sway.enable enabled;
    # Fixes an issue that normally causes nixos-rebuild to fail.
    # https://github.com/NixOS/nixpkgs/issues/180175
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
