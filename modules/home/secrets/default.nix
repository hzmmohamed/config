{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.caramelmint; let
  cfg = config.caramelmint.secrets;
in {
  options.caramelmint.secrets = with types; {
    enable =
      mkBoolOpt false
      "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    # sops = {
    #   defaultSopsFile = ./secrets.yaml;
    #   defaultSopsFormat = "yaml";

    #   age.keyFile = "/home/${config.caramelmint.user.name}/.config/sops/age/keys.txt";

    #   secrets.aws_credentials.routelab.region = {};
    #   secrets.aws_credentials.routelab.aws_access_key_id = {};
    #   secrets.aws_credentials.routelab.aws_secret_access_key = {};
    # };
  };
}
