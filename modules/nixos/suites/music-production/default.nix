{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.suites.music-production;
in {
  options.caramelmint.suites.music-production = with types; {
    enable =
      mkBoolOpt false
      "Whether or not to enable common music production configuration.";
  };

  config = mkIf cfg.enable {
    caramelmint.cli-apps.wine = enabled;

    caramelmint.home.extraOptions = {
      home.packages = with pkgs; [
        audacity
        ardour
        carla
        x42-plugins
        x42-avldrums
        #    CHOWTapeModel
        #    ChowCentaur
        #    ChowPhaser
        #    # How to get decent sampler
        #    easyeffects
        # helm
        surge-XT
        hydrogen
        lsp-plugins
        # guitarix
        sfizz
        dragonfly-reverb

        # Support for Windows VST2/VST3 plugins
        yabridge
        yabridgectl
        cadence

        qpwgraph
      ];

      home.file = {
        # Setup Yabridge
        # If you face issues with scanning the plugins in Ardour (e.g. Invalid ELF header), creating a clean Wine prefix and re-installing the plugins should fix it.
        ".config/yabridgectl/config.toml".text = ''
          plugin_dirs = ['/home/hfahmi/.wine/drive_c/Program\ Files/Common\ Files/VST3','/home/hfahmi/.wine/drive_c/Program\ Files/VstPlugins']
           vst2_location = 'centralized'
           no_verify = false
           blacklist = []
        '';
      };
    };
  };
}
