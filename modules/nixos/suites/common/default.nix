{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.suites.common;
in {
  options.caramelmint.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {

    # services.automatic-timezoned = enabled;
    caramelmint = {
      nix = enabled;

      # @TODO(jakehamilton): Enable this once Attic is configured again.
      # cache.public = enabled;

      cli-apps = { };

      tools = {
        git = enabled;
        misc = enabled;
        nix-ld = enabled;
      };

      hardware = {
        audio = enabled;
        storage = enabled;
        networking = enabled;
      };

      services = {
        printing = enabled;
        # openssh = enabled;
        tailscale = enabled;
      };

      security = {
        gpg = enabled;
        doas = enabled;
        keyring = enabled;
      };

      system = {
        fonts = enabled;
        locale = enabled;
        time = enabled;
        xkb = enabled;
      };
    };
  };
}
