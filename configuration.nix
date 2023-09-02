# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: let
  unstable = import <nixos-unstable> {};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelParams = ["i915.force_probe=46a6" "i915.enable_psr=0"];
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  security.polkit.enable = true;
  # needed by pipewire pulse
  security.rtkit.enable = true;

  # Enable swap on luks
  boot.initrd.luks.devices."luks-2d5a7033-b62c-4fad-9eac-7db206491629".device = "/dev/disk/by-uuid/2d5a7033-b62c-4fad-9eac-7db206491629";
  boot.initrd.luks.devices."luks-2d5a7033-b62c-4fad-9eac-7db206491629".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
  };
  services.thermald.enable = true;
  services.cpupower-gui.enable = true;

  services.tlp.enable = true;
  services.system76-scheduler.enable = true;
  services.smartd.enable = true;
  services.vnstat.enable = true;
  virtualisation.docker = {
    enable = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
    autoPrune.enable = true;
  };

  # Nvidia
  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    intelBusId = "PCI:00:02:0";
    nvidiaBusId = "PCI:01:00:0";
  };

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
    ];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    # open = true;

    # Fix screen tearing on external display. HDMI port is directly connected to dGPU
    forceFullCompositionPipeline = true;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.kdeconnect.enable = true;
  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["hfahmi"];
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;

  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;
  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  services.mpd.enable = true;
  services.udisks2.enable = true;

  programs.adb.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hfahmi = {
    isNormalUser = true;
    description = "Hazem Fahmi";
    extraGroups = ["networkmanager" "wheel" "video" "seat" "input" "docker" "adbusers" "libvirtd"];
  };
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
      font-awesome
      kawkab-mono-font
      roboto
      roboto-mono

      fira-code

      jetbrains-mono
      victor-mono

      noto-fonts-extra
      noto-fonts-emoji

      # Meslo Nerd fonts package contains all the needed glyphs for the tide prompt
      meslo-lgs-nf
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["FreeSerif"];
        sansSerif = ["Roboto"];
        monospace = ["JetBrainsMono"];
      };
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.hfahmi = {
    config,
    pkgs,
    ...
  }: {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "hfahmi";
    home.homeDirectory = "/home/hfahmi";
    home.shellAliases = {};
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 22;
    };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
      grim
      slurp
      xdg-utils
      dmenu

      distrobox

      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.

      xterm
      #  openshot-qt
      libreoffice
      qgis
      pdfgrep
      openlens
      rsync
      gnused

      tesseract
      ripgrep
      ripgrep-all
      # vgrep

      # webkitgtk
      # gtk3

      fontfor
      fontforge
      font-manager

      poetry
      zotero
      jdk

      alejandra

      powertop
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
      python311Packages.pip
      virtualenv
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

      pcmanfm

      digikam

      ytfzf

      ffmpeg_5
      handbrake
      mpv
      pavucontrol

      python310Packages.fn

      dbeaver
      figma-linux

      # KDE Partition Manager
      # partition-manager

      clamav

      anytype

      audacity
      ardour
      carla
      #    x42-plugins
      #    x42-avldrums
      #    CHOWTapeModel
      #    ChowCentaur
      #    ChowPhaser
      #    # How to get decent sampler
      #    easyeffects
      helm
      #    guitarix
      sfizz

      lens
      postman

      vnstat

      #
      cpupower-gui
      glib # gapplication required for cpupower-gui

      #    freecad
      kicad
      gimp
      inkscape

      libsForQt5.kgpg
      ktorrent

      kubectl
      kubernetes-helm

      spotify
      spotify-tray

      #    lapce

      nano

      fishPlugins.pisces

      obs-studio

      os-prober
      killall

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
    # programs.thunderbird = {
    #   enable = true;
    #   profiles.hfahmi = {
    #     isDefault = true;
    #     name =
    #   }
    # };

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
        {
          name = "fzf-fish";
          src = fzf-fish.src;
        }
        {
          name = "colored-man-pages";
          src = colored-man-pages.src;
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
      mako.enable = true;

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
          {id = "chphlpgkkbolifaimnlloiipkdnihall";} # OneTab
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
      # obs-studio.enable = true;
      rofi.enable = true;
      ssh.enable = true;
      tmux.enable = true;
      urxvt.enable = true;
      zellij.enable = true;
      zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
      broot.enable = true;
      waybar = {
        enable = true;
        systemd.enable = true;

        # settings = {
        #   mainBar = {
        #     layer = "top";
        #     position = "top";
        #     height = 30;
        #     spacing = 4;
        #     output = [
        #       "eDP-1"
        #       "HDMI-A-1"
        #     ];
        #     modules-left = ["sway/workspaces" "sway/mode" "custom/media"];
        #     modules-right = [
        #       "pulseaudio"
        #       "network"
        #       "cpu"
        #       "memory"
        #       "temperature"
        #       "backlight"
        #       "keyboard-state"
        #       "sway/language"
        #       "battery"
        #       "clock"
        #       "tray"
        #     ];

        #     "sway/workspaces" = {
        #       disable-scroll = true;
        #       all-outputs = true;
        #     };

        #   };
        # };
      };
    };

    # Sway
    wayland.windowManager.sway = {
      # Wrapped version of sway in nixpkgs already adds recommended command here in the sway docs https://github.com/swaywm/sway/wiki/Systemd-integration#managing-user-applications-with-systemd
      enable = true;

      wrapperFeatures.gtk = true;
      swaynag.enable = true;

      config = let
        cfg = config.wayland.windowManager.sway;
      in {
        modifier = "Mod4";
        floating.modifier = "Mod4";
        floating.border = 0;
        window.border = 0;
        bars = [];
        fonts = {
          names = ["RobotoMono"];
          size = 9.0;
        };
        focus.forceWrapping = false;
        focus.followMouse = true;
        terminal = "alacritty";
        startup = [];

        menu = "wofi --show drun";
        output = {
          eDP-1 = {
            scale = "1.2";
            mode = "1920x1080@60.002Hz";
            # bg = "";
          };
        };

        keybindings = let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
          lib.mkOptionDefault {
            "${modifier}+Return" = "exec ${cfg.config.terminal}";
            "${modifier}+q" = "kill";
            "${modifier}+space" = "exec ${cfg.config.menu}";
            "${modifier}+h" = "split h";
            "${modifier}+v" = "split v";
            "${modifier}+f" = "fullscreen";
            "${modifier}+Shift+f" = "floating toggle";
            # change focus between tiling/floating windows
            "${modifier}+d" = "focus mode_toggle";
            # focus the parent container
            "${modifier}+p" = "focus parent";

            # focus the child container
            "${modifier}+c" = "focus child";

            "${modifier}+Shift+Return" = "exec sway input 1:1:AT_Translated_Set_2_keyboard  xkb_switch_layout next";

            # Jump to urgent window
            "${modifier}+x" = "[urgent=latest] focus";

            "XF86AudioRaiseVolume" = "exec wpctl set-volume --limit 1 @DEFAULT_SINK@ 5%+";
            "XF86AudioLowerVolume" = "exec wpctl set-volume --limit 1 @DEFAULT_SINK@ 5%-";
            "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";

            # microphone
            "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_SOURCE@ toggle";

            # playback
            ## play/pause
            "XF86AudioPlay" = "exec playerctl play-pause";
            "XF86AudioNext" = "exec playerctl next";
            "XF86AudioPrev" = "exec playerctl previous";

            # brightness
            "XF86MonBrightnessUp" = "exec light -A 5";
            "XF86MonBrightnessDown" = "exec light -U 5";
            "Shift+XF86MonBrightnessUp" = "exec light -A 1";
            "Shift+XF86MonBrightnessDown" = "exec light -U 1";

            # power
            "XF86PowerOff" = "exec $Locker";
          };
        modes.resize = {
          Escape = "mode default";
          Return = "mode default";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
        };

        gaps.inner = 15;
      };
      extraConfig = ''

        # set workspace labels
        set $ws1 "1: terminal"
        set $ws2 "2: file_manager"
        set $ws3 "3: notes"
        set $ws4 "4: browser"
        set $ws5 "5: coding"
        set $ws6 "6: gis"
        set $ws7 "7: db"
        set $ws8 "8: media"
        set $ws9 "9: teams"
        set $ws10 "0: generic"


        hide_edge_borders both
        default_border pixel 5


        ####################################
        ####       XF86 SHORTCUTS       ####
        ####################################

        # volume


        ##########################
        ####     INPUT     ####
        ##########################

        input type:touchpad {
            # Further options: https://wayland.freedesktop.org/libinput/doc/latest/configuration.html
               dwt enabled # disable while typing
               tap enabled
               natural_scroll disabled
               middle_emulation enabled
           }


        input "type:keyboard" {
            xkb_layout us,ara
        }

        ##########################
        ####     BAR          ####
        ##########################



        ######################################
        ####       WAYLAND CONFIG         ####
        ######################################



        # Import the WAYLAND_DISPLAY env var from sway into the systemd user session.
        # Stop any services that are running, so that they receive the new env var when they restart.


        exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
        exec hash dbus-update-activation-environment 2>/dev/null && \
             dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK



        # Run the GUI polkit authenticaiton agent

        exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway && systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr && systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr

      '';
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

      Install = {
        WantedBy = ["graphical-session.target"];
      };
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
    services.swayidle = {
      enable = true;
    };
    programs.swaylock.enable = true;
    programs.wofi.enable = true;
    services.clipmenu = {
      enable = true;
      launcher = "rofi";
    };

    home.file.waybarConfig = {
      enable = true;
      target = ".config/waybar/config";
      text = ''
              {
            // "layer": "top", // Waybar at top layer
            // "position": "bottom", // Waybar position (top|bottom|left|right)
            "height": 30, // Waybar height (to be removed for auto height)
            // "width": 1280, // Waybar width
            "spacing": 4, // Gaps between modules (4px)
            // Choose the order of the modules
            "modules-left": [
                "sway/workspaces",
                "sway/mode",
                "custom/media"
            ],
            //"modules-center": ["sway/window"],
            "modules-right": [
                // "idle_inhibitor",
                "pulseaudio",
                "network",
                "cpu",
                "memory",
                "temperature",
                "backlight",
                "keyboard-state",
                "sway/language",
                "battery",
                "battery#bat2",
                "clock",
                "tray"
            ],
            // Modules configuration
            "sway/workspaces": {
                "disable-scroll": true,
                "all-outputs": true,
                //"format": "{name}: {icon}",
                //"format": "{icon}",
                //"format-icons": {
                 //   "1": "",
                 //   "2": "",
                 //   "3": "",
                 //   "4": "",
                 //   "5": "",
                 //   "urgent": "",
                 //  "focused": "",
                 //   "default": ""
               // }
            },
            "keyboard-state": {
                "numlock": true,
                "capslock": true,
                "format": "{name} {icon}",
                "format-icons": {
                    "locked": "",
                    "unlocked": ""
                }
            },
            "sway/mode": {
                "format": "<span style=\"italic\">{}</span>"
            },

            "tray": {
                // "icon-size": 21,
                "spacing": 10
            },
            "clock": {
                // "timezone": "America/New_York",
                "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
                "format-alt": "{:%Y-%m-%d}"
            },
            "cpu": {
                "format": "{usage}% ",
                "tooltip": false
            },
            "memory": {
                "format": "{}% "
            },
            "temperature": {
                // "thermal-zone": 2,
                // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
                "critical-threshold": 80,
                // "format-critical": "{temperatureC}°C {icon}",
                "format": "{temperatureC}°C {icon}",
                "format-icons": [
                    "",
                    "",
                    ""
                ]
            },
            "backlight": {
                // "device": "acpi_video1",
                "format": "{percent}% {icon}",
                "format-icons": [
                    "",
                    ""
                ]
            },
            "battery": {
                "states": {
                    // "good": 95,
                    "warning": 30,
                    "critical": 15
                },
                "format": "{capacity}% {icon}",
                "format-charging": "{capacity}% ",
                "format-plugged": "{capacity}% ",
                "format-alt": "{time} {icon}",
                // "format-good": "", // An empty format will hide the module
                // "format-full": "",
                "format-icons": [
                    "",
                    "",
                    "",
                    "",
                    ""
                ]
            },
            "battery#bat2": {
                "bat": "BAT2"
            },
            "network": {
                // "interface": "wlp2*", // (Optional) To force the use of this interface
                "format-wifi": "{essid} ({signalStrength}%) ",
                "format-ethernet": "{ipaddr}/{cidr} ",
                "tooltip-format": "{ifname} via {gwaddr} ",
                "format-linked": "{ifname} (No IP) ",
                "format-disconnected": "Disconnected ⚠",
                "format-alt": "{ifname}: {ipaddr}/{cidr}"
            },
            "pulseaudio": {
                // "scroll-step": 1, // %, can be a float
                "format": "{volume}% {icon} {format_source}",
                "format-bluetooth": "{volume}% {icon} {format_source}",
                "format-bluetooth-muted": " {icon} {format_source}",
                "format-muted": " {format_source}",
                "format-source": "{volume}% ",
                "format-source-muted": "",
                "format-icons": {
                    "headphone": "",
                    "hands-free": "",
                    "headset": "",
                    "phone": "",
                    "portable": "",
                    "car": "",
                    "default": [
                        "",
                        "",
                        ""
                    ]
                },
                "on-click": "pavucontrol"
            },
            "custom/media": {
                "format": "{icon} {}",
                "return-type": "json",
                "max-length": 40,
                "format-icons": {
                    "spotify": "",
                    "default": "🎜"
                },
                "escape": true,
                "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" // Script in resources folder
                // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
            }
        }

      '';
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
    home.sessionVariables = {
      EDITOR = "nano";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
      SDL_VIDEODRIVER = "wayland";

      # needs qt5.qtwayland in systemPackages
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # DISPLAY = ":1";
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      _JAVA_AWT_WM_NONREPARENTING = 1;

      # gtk applications on wayland
      GDK_BACKEND = "wayland";

      # Fractional scaling
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
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
        donjayamanne.githistory
        mhutchie.git-graph
        mikestead.dotenv
        naumovs.color-highlight
        vincaslt.highlight-matching-tag
        foxundermoon.shell-format
        jebbs.plantuml
        antyos.openscad

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

    # Let Home Manager install and manage itself.
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    polkit_gnome
    lm_sensors
    smartmontools
    polkit_gnome

    # Virt manager setup
    virt-manager
    virt-viewer
    virtiofsd
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    gnome.adwaita-icon-theme
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.logkeys.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  services.xserver.libinput.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sessionPackages = [pkgs.sway];
  # hardware.opengl.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.light.enable = true;

  # Git NixOS option
  programs.git.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.copySystemConfiguration = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
