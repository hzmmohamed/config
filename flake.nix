{
  description = "Caramel Mint";

  inputs = {
    # NixPkgs (nixos-23.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # NixPkgs Unstable (nixos-unstable)
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager (release-23.11)
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS Support (master)
    # darwin.url = "github:lnl7/nix-darwin";
    # darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Generate System Images
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # Snowfall Lib
    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    # Snowfall Flake
    flake.url = "github:snowfallorg/flake";
    flake.inputs.nixpkgs.follows = "unstable";

    # Comma
    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "unstable";

    # System Deployment
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "unstable";

    # Run unpatched dynamically compiled binaries
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "unstable";

    # Vault Integration
    vault-service = {
      url = "github:DeterminateSystems/nixos-vault-service/a9f2a1c5577491da73d2c13f9bafff529445b760";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake Hygiene
    flake-checker = {
      url = "github:DeterminateSystems/flake-checker/46b02e6172ed961113d336a035688ac12c96d9f4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plusultra = {
      url = "github:jakehamilton/config";
      inputs.nixpkgs.follows = "unstable";
      inputs.unstable.follows = "unstable";
    };

    # # Backup management
    # icehouse = {
    #   url = "github:snowfallorg/icehouse";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.unstable.follows = "unstable";
    # };

    # GPG default configuration
    gpg-base-conf = {
      url = "github:drduh/config";
      flake = false;
    };

    # Add devenv flake input
    devenv = {
      url = "github:cachix/devenv/latest";
      inputs.nixpkgs.follows = "unstable";
    };

    # TODO: Adding this input to remind myself to learn to use it. This should be, in principle, easier than setting up formatters from pre-commit-hooks.nix
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "unstable";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "caramelmint";
          title = "Caramel Mint";
        };

        namespace = "caramelmint";
      };
    };
  in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
        # This version of Electron is EOL, but latest Obsidian still uses it.
        permittedInsecurePackages = [
          "electron-25.9.0"
        ];
      };

      lib = with inputs; [
        plusultra.lib
      ];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        nix-ld.nixosModules.nix-ld
        vault-service.nixosModules.nixos-vault-service
        sops-nix.nixosModules.sops
      ];

      # deploy = lib.mkDeploy {inherit (inputs) self;};

      # checks =
      #   builtins.mapAttrs
      #   (system: deploy-lib:
      #     deploy-lib.deployChecks inputs.self.deploy)
      #   inputs.deploy-rs.lib;
    };
}
