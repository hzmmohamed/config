{
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
    wineWowPackages.stable
    winetricks

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
}
