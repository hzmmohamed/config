{
  config,
  pkgs,
  unstable,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hfahmi";
  home.homeDirectory = "/home/hfahmi";
  home.shellAliases = {};

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    xterm
    openshot-qt
    libreoffice
    qgis
    pdfgrep
    delta

    rsync
    gnused

    gnome-frog
    gnome.gnome-tweaks
    gnome-extension-manager
    gnomeExtensions.workspaces-bar
    gnomeExtensions.space-bar
    unstable.gnomeExtensions.top-bar-organizer
    # gnomeExtensions.animation-tweaks
    gnomeExtensions.impatience
    gnomeExtensions.just-perfection
    gnomeExtensions.cpufreq

    tesseract
    ripgrep
    ripgrep-all
    # vgrep

    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
    fontfor
    fontforge
    font-awesome
    kawkab-mono-font
    noto-fonts-extra
    roboto
    roboto-mono
    fira-code
    jetbrains-mono
    victor-mono
    font-manager
    alejandra

    vnstat
    fx
    jqp
    p7zip
    fd
    pv
    gawk
    strace
    lurk

    tree
    zoom-us

    virt-manager

    nil # LSP for Nix

    bind # https://releases.nixos.org/nix-dev/2015-September/018037.html
    gcc
    vlc
    nnn
    lf
    efibootmgr
    entr
    pciutils
    python311
    wget
    glances
    progress
    awscli2
    bind
    kind
    ctlptl
    dive
    tilt
    docker-compose

    logkeys

    digikam

    ytfzf

    ffmpeg_5
    handbrake
    mpv

    python310Packages.fn

    dbeaver
    figma-linux

    gnomeExtensions.vitals
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar

    # KDE Partition Manager
    # partition-manager

    clamav

    anytype

    ardour
    carla
    x42-plugins
    x42-avldrums
    CHOWTapeModel
    ChowCentaur
    ChowPhaser
    # How to get decent sampler
    easyeffects
    helm
    guitarix
    pavucontrol
    sfizz

    lens
    postman

    powertop

    vnstat

    freecad
    kicad
    gimp
    inkscape

    libsForQt5.kgpg
    ktorrent

    kubectl
    kubernetes-helm

    lapce
    lazygit

    nano

    # Meslo Nerd fonts package contains all the needed glyphs for the tide prompt
    meslo-lgs-nf
    fishPlugins.pisces

    noto-fonts-extra
    noto-fonts-emoji

    obs-studio
    os-prober

    gzip

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";
    };
    shellAbbrs = {
      g = "git";
      o = "open";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        src = tide.src;
      }
      {
        name = "pisces";
        src = pisces.src;
      }
    ];
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
  programs.bash = {
    enable = true;
    # Copied from Arch Wiki https://wiki.archlinux.org/title/fish
    initExtra = ''
      if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z $BASH_EXECUTION_STRING ]]
      then
      	exec fish
      fi
    '';
  };
  programs.alacritty.enable = true;
  services = {
    flameshot.enable = true;
    redshift = {
      enable = true;
      provider = "geoclue2";
    };
    gpg-agent.enable = true;
  };

  programs = {
    # https://github.com/eth-p/bat-extras
    bat.enable = true;

    btop.enable = true;
    neovim.enable = true;

    chromium = {
      enable = true;
      extensions = [
        {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
      ];
    };
    fzf.enable = true;
    lsd = {
      enable = true;
      enableAliases = true;
    };
    git = {
      enable = true;
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "GitHub";
        };
      };
    };
    gpg.enable = true;
    lf.enable = true;
    lazygit = {
      enable = true;
    };
    less.enable = true;
    mcfly = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      fuzzySearchFactor = 4;
      keyScheme = "vim";
    };

    micro.enable = true;
    mpv.enable = true;
    navi.enable = true;
    pandoc.enable = true;
    obs-studio.enable = true;
    rofi.enable = true;
    ssh.enable = true;
    tmux.enable = true;
    urxvt.enable = true;
    zellij.enable = true;
    zoxide.enable = true;
    broot.enable = true;
  };

  editorconfig = {
    enable = true;
    settings = {}; # https://github.com/nix-community/home-manager/blob/master/modules/misc/editorconfig.nix
  };

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-10 = ["<Super>0"];

      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      move-to-workspace-5 = ["<Shift><Super>5"];
      move-to-workspace-6 = ["<Shift><Super>6"];
      move-to-workspace-7 = ["<Shift><Super>7"];
      move-to-workspace-8 = ["<Shift><Super>8"];
      move-to-workspace-9 = ["<Shift><Super>9"];
      move-to-workspace-10 = ["<Shift><Super>0"];
    };
    "org/gnome/mutter" = {
      focus-change-on-pointer-rest = false;
    };
    "org/gnome/shell" = {
      show-screenshot-ui = ["<Shift><Super>s"];
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
      enabled-extensions = [
        # "user-theme@gnome-shell-extensions.gcampax.github.com"
        # "trayIconsReloaded@selfmade.pl"
        "Vitals@CoreCoding.com"
        # "dash-to-panel@jderose9.github.com"
        "sound-output-device-chooser@kgshank.net"
        "space-bar@luchrioh"
      ];
    };
    "org/gnome/desktop/interface" = {
      enable-animations = false;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
  };

  targets.genericLinux.enable = true;

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hfahmi/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Install and Configure VSCodium
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = true; # default
    extensions = with pkgs.vscode-extensions; [
      tomoki1207.pdf
      ms-python.python
      editorconfig.editorconfig
      kamadorueda.alejandra
      jnoortheen.nix-ide
      emmanuelbeziat.vscode-great-icons
      # vscodevim.vim
    ];
  };
  # Allow mutable settings.json at runtime, and rewritten on running `home-manager switch`
  # Reference: https://github.com/nix-community/home-manager/issues/1800
  home.activation.afterWriteBoundary = let
    userSettings = {
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;

      "nix.serverPath" = "nil";
      "nix.serverSettings" = {};
      "workbench.colorTheme" = "Quiet Light";
      "workbench.sideBar.location" = "right";
      "window.zoomLevel" = 1;
      "editor.wordWrap" = "on";
    };
    configDir = "VSCodium";
    userSettingsFilePath = "${config.xdg.configHome}/${configDir}/User/settings.json";
  in {
    after = ["writeBoundary"];
    before = [];
    data = ''
      rm -rf ${userSettingsFilePath}
      cat ${pkgs.writeText "tmp_vscode_settings" (builtins.toJSON userSettings)} | ${pkgs.jq}/bin/jq --monochrome-output > ${userSettingsFilePath}
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
