{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.tools.obsidian;
in {
  options.caramelmint.tools.obsidian = with types; {
    enable = mkBoolOpt false "Whether to enable Obsidian.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {
      home.packages = with pkgs; [
        unstable.obsidian
      ];

      # TODO: This overwrites the env var rather than append to it. The original value has something to do with pipewire. A better approach is to wrap obsidian with wrapProgram
      # https://discourse.nixos.org/t/electron-apps-cant-find-opengl/35713/14?u=hfahmi
      home.sessionVariables = {
        LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
      };
    };
  };
}
