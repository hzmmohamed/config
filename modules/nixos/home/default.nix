{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.home;
in {
  # imports = with inputs; [
  #   home-manager.nixosModules.home-manager
  # ];

  options.caramelmint.home = with types; {
    file =
      mkOpt attrs {}
      (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile =
      mkOpt attrs {}
      (mdDoc "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs {} "Options to pass directly to home-manager.";
  };

  config = {
    caramelmint.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.caramelmint.home.file;
      xdg.configFile = mkAliasDefinitions options.caramelmint.home.configFile;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${config.caramelmint.user.name} =
        mkAliasDefinitions options.caramelmint.home.extraOptions;
    };
  };
}
