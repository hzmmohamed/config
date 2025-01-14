{
  description = "Caramel Mint";

  inputs = {
    # NixPkgs (nixos-24.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    stylix.url = "github:danth/stylix/release-24.11";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    # System Deployment
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    # NixPkgs Unstable (nixos-unstable)
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-colors.url = "github:misterio77/nix-colors";
    catppuccin.url = "github:catppuccin/nix";

    nv.url = "github:hzmmohamed/nv";

    # Home Manager (release-23.11)
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    flake.inputs.nixpkgs.follows = "nixpkgs";

    # Flake Hygiene
    flake-checker = {
      url =
        "github:DeterminateSystems/flake-checker/46b02e6172ed961113d336a035688ac12c96d9f4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # GPG default configuration
    gpg-base-conf = {
      url = "github:drduh/config";
      flake = false;
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

    musnix = { url = "github:musnix/musnix"; };
  };

  outputs = inputs:
    let
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
    in lib.mkFlake {
      channels-config = {
        allowUnfree = true;
        # This version of Electron is EOL, but latest Obsidian still uses it.
        permittedInsecurePackages = [ "electron-25.9.0" ];
      };

      systems.modules.nixos = with inputs; [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        sops-nix.nixosModules.sops
        musnix.nixosModules.musnix
        disko.nixosModules.disko
        stylix.nixosModules.stylix
      ];

      homes.users.hfahmi.modules = with inputs; [
        nix-colors.homeManagerModules.default
        catppuccin.homeManagerModules.catppuccin
        nix-index-database.hmModules.nix-index
        stylix.homeManagerModules.stylix
      ];

      deploy = lib.mkDeploy { inherit (inputs) self; };

      checks = builtins.mapAttrs
        (system: deploy-lib: deploy-lib.deployChecks inputs.self.deploy)
        inputs.deploy-rs.lib;
    };
}
