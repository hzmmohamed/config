{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.caramelmint;
let
  cfg = config.caramelmint.nix;

  substituters-submodule = types.submodule ({ name, ... }: {
    options = with types; {
      key =
        mkOpt (nullOr str) null "The trusted public key for this substituter.";
    };
  });
in {
  options.caramelmint.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixVersions.latest "Which nix package to use.";

    default-substituter = {
      url = mkOpt str "https://cache.nixos.org" "The url for the substituter.";
      key = mkOpt str
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "The trusted public key for the substituter.";
    };

    extra-substituters = mkOpt (attrsOf substituters-submodule) { }
      "Extra substituters to configure.";
  };

  config = mkIf cfg.enable {
    assertions = mapAttrsToList (name: value: {
      assertion = value.key != null;
      message = "caramelmint.nix.extra-substituters.${name}.key must be set";
    }) cfg.extra-substituters;

    environment.systemPackages = with pkgs; [
      # inputs.plusultra.nixos-revision
      # (inputs.plusultra.nixos-hosts.override {
      #   hosts = inputs.self.nixosConfigurations;
      # })
      deploy-rs
      nixfmt
      # alejandra
      nix-index

      nix-prefetch-scripts

      nvd
      nix-diff
      nh
      nix-output-monitor

      nix-inspect
      nix-du
      nix-melt

      nixos-facter

      # flake-checker
      hydra-check
    ];

    nix = let
      users = [ "root" config.caramelmint.user.name ]
        ++ optional config.services.hydra.enable "hydra";
    in {
      package = cfg.package;

      settings = {
        experimental-features = "nix-command flakes";
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        # sandbox = "relaxed";
        auto-optimise-store = true;
        trusted-users = users;
        allowed-users = users;

        substituters = [ cfg.default-substituter.url ]
          ++ (mapAttrsToList (name: value: name) cfg.extra-substituters);
        trusted-public-keys = [ cfg.default-substituter.key ]
          ++ (mapAttrsToList (name: value: value.key) cfg.extra-substituters);
      };
      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
        fallback = true
        connect-timeout = 5
      '';
      # ++ (if config.caramelmint.tools.direnv.enable == true then ''
      #   keep-outputs = true;
      #   keep-derivations = true;
      # '' else
      #   "");

      gc = {
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than 30d";
      };

      # flake-utils-plus
      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      generateRegistryFromInputs = true;
      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}
