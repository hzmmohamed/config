# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./wm/sway.nix
    ./wm/waybar.nix
    ./wm/wlogout
    ./wm/gtk.nix
    ./tools/development.nix
    ./tools/nvim.nix
    ./tools/fish.nix
    ./tools/pro-audio.nix
    ./tools/productivity.nix
    # ./theme
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "hfahmi";
    homeDirectory = "/home/hfahmi";
    sessionVariables = {
      # EDITOR = "nano";
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gnome.adwaita-icon-theme

    grim
    slurp

    # xdg-utils

    # system monitoring and perf
    powertop
    vnstat
    cpupower-gui
    glib # gapplication required for cpupower-gui and I think any GTK application

    # Editors
    lapce
    nano
    micro

    # Low-level OS
    os-prober
    efibootmgr

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

  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        # Default colors
        primary = {
          background = "#EFF1F5"; # base
          foreground = "#4C4F69"; # text
          # Bright and dim foreground colors
          dim_foreground = "#4C4F69"; # text
          bright_foreground = "#4C4F69"; # text
        };

        # Cursor colors
        cursor = {
          text = "#EFF1F5"; # base
          cursor = "#DC8A78"; # rosewater
        };
        vi_mode_cursor = {
          text = "#EFF1F5"; # base
          cursor = "#7287FD"; # lavender
        };
        # Search colors
        search = {
          matches = {
            foreground = "#EFF1F5"; # base
            background = "#6C6F85"; # subtext0
          };
          focused_match = {
            foreground = "#EFF1F5"; # base
            background = "#40A02B"; # green
          };
          footer_bar = {
            foreground = "#EFF1F5"; # base
            background = "#6C6F85"; # subtext0
          };
        };
        # Keyboard regex hints
        hints = {
          start = {
            foreground = "#EFF1F5"; # base
            background = "#DF8E1D"; # yellow
          };
          end = {
            foreground = "#EFF1F5"; # base
            background = "#6C6F85"; # subtext0
          };
        };

        # Selection colors
        selection = {
          text = "#EFF1F5"; # base
          background = "#DC8A78"; # rosewater
        };
        # Normal colors
        normal = {
          black = "#5C5F77"; # subtext1
          red = "#D20F39"; # red
          green = "#40A02B"; # green
          yellow = "#DF8E1D"; # yellow
          blue = "#1E66F5"; # blue
          magenta = "#EA76CB"; # pink
          cyan = "#179299"; # teal
          white = "#ACB0BE"; # surface2
        };
        # Bright colors
        bright = {
          black = "#6C6F85"; # subtext0
          red = "#D20F39"; # red
          green = "#40A02B"; # green
          yellow = "#DF8E1D"; # yellow
          blue = "#1E66F5"; # blue
          magenta = "#EA76CB"; # pink
          cyan = "#179299"; # teal
          white = "#BCC0CC"; # surface1
        };
        # Dim colors
        dim = {
          black = "#5C5F77"; # subtext1
          red = "#D20F39"; # red
          green = "#40A02B"; # green
          yellow = "#DF8E1D"; # yellow
          blue = "#1E66F5"; # blue
          magenta = "#EA76CB"; # pink
          cyan = "#179299"; # teal
          white = "#ACB0BE"; # surface2
        };

        indexed_colors = [
          {
            index = 16;
            color = "#FE640B";
          }
          {
            index = 17;
            color = "#DC8A78";
          }
        ];
      };
    };
  };
  programs.foot = {
    enable = true;
    settings = {
      colors = {
        foreground = "4c4f69"; # Text
        background = "eff1f5"; # Base
        regular0 = "5c5f77"; # Subtext 1
        regular1 = "d20f39"; # red
        regular2 = "40a02b"; # green
        regular3 = "df8e1d"; # yellow
        regular4 = "1e66f5"; # blue
        regular5 = "ea76cb"; # pink
        regular6 = "179299"; # teal
        regular7 = "acb0be"; # Surface 2
        bright0 = "6c6f85"; # Subtext 0
        bright1 = "d20f39"; # red
        bright2 = "40a02b"; # green
        bright3 = "df8e1d"; # yellow
        bright4 = "1e66f5"; # blue
        bright5 = "ea76cb"; # pink
        bright6 = "179299"; # teal
        bright7 = "bcc0cc"; # Surface 1
      };
    };
  };

  services = {
    # Not needed as a service and I can't get the tray indicator to show anyway.
    flameshot.enable = true;
    gpg-agent.enable = true;
  };

  programs = {
    # https://github.com/eth-p/bat-extras
    bat.enable = true;

    btop.enable = true;

    chromium = {
      enable = true;
      extensions = [
        {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
        {id = "chphlpgkkbolifaimnlloiipkdnihall";} # OneTab
        {id = "ekhagklcjbdpajgpjgmbionohlpdbjgc";} # Zotero Connector
        {id = "blkggjdmcfjdbmmmlfcpplkchpeaiiab";} # Omnivore
      ];
    };

    fzf.enable = true;
    lsd = {
      enable = true;
      enableAliases = true;
    };

    git = {
      enable = true;
      userName = "hzmmohamed";
      userEmail = "hzmmohamed@gmail.com";
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

    less.enable = true;

    mcfly = {
      enable = true;
      fuzzySearchFactor = 4;
      keyScheme = "vim";
    };

    mpv.enable = true;

    pandoc.enable = true;

    ssh.enable = true;

    urxvt.enable = true;

    # tmux.enable = true;
    zellij = {
      enable = true;
      # enableFishIntegration = true;
    };

    zoxide = {enable = true;};
    broot.enable = true;
  };
  services.gammastep = {
    #https://nixos.wiki/wiki/Gammastep
    enable = true;
    tray = true;
    dawnTime = "05:00";
    duskTime = "19:00";
  };

  systemd.user.services.polkit-gnome = {
    Unit = {
      Description = "PolicyKit Authentication Agent";
      After = ["graphical-session-pre.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    };

    Install = {WantedBy = ["graphical-session.target"];};
  };
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.playerctld.enable = true;
  services.mpris-proxy.enable = true;

  services.kanshi.enable = true;
  services.dunst.enable = true;
  services.udiskie = {
    enable = true;
    tray = "always";
  };

  services.blueman-applet.enable = true;
  programs.wofi.enable = true;

  services.clipmenu = {
    enable = true;
    launcher = "rofi";
  };

  editorconfig = {
    enable = true;
    settings = {}; # https://github.com/nix-community/home-manager/blob/master/modules/misc/editorconfig.nix
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
  xdg.configFile."xdg-desktop-portal-wlr/config".text = ''
    [screencast]
    output_name=
    max_fps=30
    chooser_cmd=${pkgs.slurp}/bin/slurp -f %o -or
    chooser_type=simple
  '';

  # Install and Configure VSCodium
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = true; # default
    extensions = with pkgs.vscode-extensions; [
      tomoki1207.pdf
      # Theming
      emmanuelbeziat.vscode-great-icons

      # Git
      donjayamanne.githistory
      mhutchie.git-graph

      mikestead.dotenv
      editorconfig.editorconfig
      naumovs.color-highlight
      vincaslt.highlight-matching-tag

      # Programming language tooling
      # Python
      ms-python.python
      ms-toolsai.jupyter
      ms-toolsai.vscode-jupyter-slideshow
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.jupyter-renderers
      ms-toolsai.jupyter-keymap
      # Shell
      foxundermoon.shell-format
      # PlantUML
      jebbs.plantuml
      # Go
      golang.go
      # OpenSCAD
      antyos.openscad
      # Nix
      kamadorueda.alejandra
      jnoortheen.nix-ide

      # vscodevim.vim
    ];
  };

  # Allow mutable settings.json at runtime, and rewritten on running `home-manager switch`
  # Reference: https://github.com/nix-community/home-manager/issues/1800
  home.activation.afterWriteBoundary = let
    userSettings = {
      "window.zoomLevel" = 1;
      "workbench.sideBar.location" = "right";
      "workbench.colorTheme" = "Quiet Light";
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
      "editor.wordWrap" = "on";
      "nix.serverPath" = "nil";
    };
    configDir = "VSCodium";
    userSettingsDirPath = "${config.xdg.configHome}/${configDir}/User";
    userSettingsFilePath = "${userSettingsDirPath}/settings.json";
  in {
    after = ["writeBoundary"];
    before = [];
    data = ''
      mkdir -p ${userSettingsDirPath}
      cat ${pkgs.writeText "tmp_vscode_settings" (builtins.toJSON userSettings)} | ${pkgs.jq}/bin/jq --monochrome-output > ${userSettingsFilePath}
    '';
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
