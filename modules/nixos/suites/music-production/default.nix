{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.suites.music-production;
in {
  options.caramelmint.suites.music-production = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common music production configuration.";
  };

  config = mkIf cfg.enable {

    musnix = enabled;
    caramelmint.cli-apps.wine = enabled;

    caramelmint.home.extraOptions = {
      home.packages = with pkgs; [
        kdenlive
        audacity
        unstable.ardour
        # unstable.decent-sampler
        carla
        x42-plugins
        x42-avldrums
        fire
        paulstretch
        cardinal
        drumgizmo
        sooperlooper
        CHOWTapeModel
        airwindows-lv2
        #  ChowCentaur
        #  ChowPhaser
        #  easyeffects
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

        # Removed from nixpkgs
        # cadence

        qpwgraph
      ];

      # https://discourse.nixos.org/t/audio-plugins-no-longer-detected-after-switching-to-nix-2-4-flakes/17177/4
      home.sessionVariables = {
        DSSI_PATH =
          "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi:/etc/profiles/per-user/$USER/lib/dssi";
        LADSPA_PATH =
          "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa:/etc/profiles/per-user/$USER/lib/ladspa";
        LV2_PATH =
          "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2:/etc/profiles/per-user/$USER/lib/lv2";
        LXVST_PATH =
          "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst:/etc/profiles/per-user/$USER/lib/lxvst";
        VST_PATH =
          "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst:/etc/profiles/per-user/$USER/lib/vst";
      };
      # home.file = {
      #   # Setup Yabridge
      #   # If you face issues with scanning the plugins in Ardour (e.g. Invalid ELF header), creating a clean Wine prefix and re-installing the plugins should fix it.
      #   # TODO: Remove username specific parts of the paths
      #   ".config/yabridgectl/config.toml".text = ''
      #     plugin_dirs = ['/home/hfahmi/.wine/drive_c/Program\ Files/Common\ Files/VST3','/home/hfahmi/.wine/drive_c/Program\ Files/VstPlugins']
      #      vst2_location = 'centralized'
      #      no_verify = false
      #      blacklist = []
      #   '';
      # };
    };
  };
}
