{
  description = "NixOS configuration";

  inputs = {
    # NixPkgs (nixos-23.05)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # NixPkgs Unstable (nixos-unstable)
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager (release-22.05)
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Generate System Images
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # Run unpatched dynamically compiled binaries
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-generators,
    ...
  }: {
    packages.x86_64-linux = {
      installer = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          # you can include your own nixos configuration here, i.e.
          # ./configuration.nix
        ];
        format = "install-iso";
      };
    };
  };

  # outputs = {
  #   nixpkgs,
  #   unstable,
  #   home-manager,
  #   ...
  # }: let
  #   system = "x86_64-linux";
  # in {
  #   homeConfigurations."hfahmi" = home-manager.lib.homeManagerConfiguration {
  #     pkgs = nixpkgs.legacyPackages.${system};
  #     extraSpecialArgs = {
  #       unstable = unstable.legacyPackages.${system};
  #     };

  #     # Specify your home configuration modules here, for example,
  #     # the path to your home.nix.
  #     modules = [./home.nix];

  #     # Optionally use extraSpecialArgs
  #     # to pass through arguments to home.nix
  #   };
  # };
}
