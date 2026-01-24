{ lib, pkgs, config, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.services.tailscale;
in {
  options.caramelmint.services.tailscale = with types; {
    enable = mkBoolOpt false "Whether or not to configure Tailscale";
    autoconnect = {
      enable = mkBoolOpt false
        "Whether or not to enable automatic connection to Tailscale";
      key = mkOpt str "" "The authentication key to use";
    };
  };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = cfg.autoconnect.enable -> cfg.autoconnect.key != "";
      message = "caramelmint.services.tailscale.autoconnect.key must be set";
    }];

    environment.systemPackages = with pkgs; [ tailscale ];

    services.tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      extraUpFlags = [ "--ssh" ];
    };

    # Attempt to run OpenSnitch with the intention of using it to monitor the network requests coming into the firewall. 
    # services.opensnitch = {
    #   enable = true;
    #   # settings.Firewall = "iptables";
    # };
    # caramelmint.home.extraOptions = { services.opensnitch-ui = enabled; };

    # Ref: https://tailscale.com/kb/1096/nixos-minecraft
    networking.firewall = {
      # enable the firewall
      enable = true;

      # always allow traffic from your Tailscale network
      trustedInterfaces = [ config.services.tailscale.interfaceName ];

      # Strict reverse path filtering breaks Tailscale exit node use and some subnet routing setups.
      checkReversePath = "loose";

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [ config.services.tailscale.port ];

      # let you SSH in over the public internet
      allowedTCPPorts = [ 22 ];
    };
  };

}
