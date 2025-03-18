{ options, config, lib, pkgs, inputs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.suites.development;
in {
  options.caramelmint.suites.development = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts =
      [ 12345 3000 3001 4000 8080 8081 9090 ];

    services.logkeys.enable = true;

    caramelmint = {
      apps = { vscode = enabled; };

      tools = {
        direnv = enabled;
        git = enabled;
        adb = enabled;
      };

      virtualisation = {
        docker = enabled;
        kvm = enabled;
      };

      home.extraOptions = {
        home.packages = with pkgs; [
          inputs.nv.packages.${pkgs.system}.default
          qgis-ltr

          jetbrains.idea-community
          mongodb-compass

          dbeaver-bin
          sway-launcher-desktop

          curlie
          insomnia
          aws-vault
          awscli2
          eksctl

          # K8s/Cloud Management tools
          kubectl
          kubernetes-helm
          kubectx
          unstable.lens
          stern
          k9s

          cloudlens

          kind
        ];
        home.sessionVariables = { AWS_VAULT_BACKEND = "file"; };
        # sops.templates.".aws/credentials".content = ''
        #   [routelab]
        #   aws_access_key_id=${config.sops.placeholder.aws_credentials.routelab.aws_access_key_id}
        #   aws_secret_access_key=${config.sops.placeholder.aws_credentials.routelab.aws_secret_access_key}
        # '';
        # home.file.aws-credentials = {
        #   target = ".aws/credentials";
        #   text = ''

        #   '';
        # };
      };
    };
  };
}
