# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./nvidia.nix
    ./bluetooth.nix
    ./locale.nix
    ./nvidia.nix
    ./modules/fonts.nix
    ./modules/virt.nix
    ./modules/security.nix

    ./home-manager.nix
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
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath =
      lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
      config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = ["nix-command flakes repl-flake"];
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      trusted-users = ["hfahmi"];
    };

    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
  };

  networking.hostName = "nixos";
  networking.firewall.enable = false;

  # Bootloader and kernel params
  boot = {
    # Bootloader
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";

    # Setup keyfile
    initrd.secrets = {"/crypto_keyfile.bin" = null;};
    # Enable swap on luks
    initrd.luks.devices."luks-2d5a7033-b62c-4fad-9eac-7db206491629".device = "/dev/disk/by-uuid/2d5a7033-b62c-4fad-9eac-7db206491629";
    initrd.luks.devices."luks-2d5a7033-b62c-4fad-9eac-7db206491629".keyFile = "/crypto_keyfile.bin";

    # Kernel
    kernelParams = ["i915.force_probe=46a6"];
    blacklistedKernelModules = [
      "nouveau"
      # "intel_lpss_pci"
    ];
  };
  # Networking
  networking.networkmanager.insertNameservers = ["1.1.1.1" "8.8.8.8"];

  # systemd
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    logkeys.enable = true;
    flatpak.enable = true;

    # CPU and Power-related config
    upower = {
      enable = true;
      criticalPowerAction = "Hibernate";
    };
    asusd = {
      enable = true;
      enableUserService = true;
    };

    thermald.enable = true;
    cpupower-gui.enable = true;

    tlp = {
      enable = true;
      settings = {
        # Force battery mode by default even when AC power is connected
        # https://linrunner.de/tlp/settings/operation.html#tlp-persistent-default
        TLP_DEFAULT_MODE = "BAT";
        TLP_PERSISTENT_DEFAULT = 1;

        # Battery Care
        # Battery Charging Threshold
        START_CHARGE_THRESH_BAT0 =
          0; # dummy (https://linrunner.de/tlp/settings/bc-vendors.html#asus)
        STOP_CHARGE_THRESH_BAT0 = 60;

        # iGPU Frequencies config. Leaving to default (dummy value) for now. Could be useful if I really need extreme power saving.
        INTEL_GPU_MIN_FREQ_ON_AC = 0;
        INTEL_GPU_MIN_FREQ_ON_BAT = 0;
        INTEL_GPU_MAX_FREQ_ON_AC = 0;
        INTEL_GPU_MAX_FREQ_ON_BAT = 0;
        INTEL_GPU_BOOST_FREQ_ON_AC = 0;
        INTEL_GPU_BOOST_FREQ_ON_BAT = 0;

        # Radio Devices
        # Disable Bluetooth onboot
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";

        # Energy profiles
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        # Platform profiles
        # This is described generally as related to "power/performance levels, thermal and fan speed". I don't need to tweak fan profiles anyway. But I wonder if changing from balanced to quiet affects battery life, and how exactly?
        # However, I want an indicator status bar widget, plus a tool to switch between modes.

        # Processor
        # Given that there are more than two options for CPU scaling governor and energy profile, I don't like the limitation of havivng only two states in TLP. I will not use TLP's processor profile configutation.

        # TLP is used here just to set the default settings using the BAT profile

        # I will, instead, use directly cpu-power GUI for ad-hoc changing processor settings.

        # For platform profile, I can use asusctl, but I should test its impact of battery life and laptop temperature first.

        # VM Writeback timeout (Don't touch it. The kernel dynamically adjusts it for the best performance)
        # https://askubuntu.com/a/1451198
      };
    };

    switcherooControl.enable = true;
    system76-scheduler.enable = true;
    smartd.enable = true;
    vnstat.enable = true;
    mpd.enable = true;
    udisks2.enable = true;
    # This setups a SSH server. Very important if you're setting up a headless system.
    # Feel free to remove if you don't need it.
    openssh = {
      enable = true;
      # Forbid root login through SSH.
      settings = {
        # Use keys only. Remove if you want to SSH using password (not recommended)
        PasswordAuthentication = false;
      };
    };
  };

  # Real-time Audio
  specialisation = {
    rt_audio.configuration = {musnix = {enable = true;};};
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.kdeconnect.enable = true;
  programs.adb.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.light.enable = true;
  programs.git.enable = true;

  # XDG Portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # Docker (Rootless by default)
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  users.users = {
    hfahmi = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "changeme";
      isNormalUser = true;
      description = "Hazem Fahmi";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "seat"
        "input"
        "docker"
        "adbusers"
        "libvirtd"
        "audio"
      ];

      # TODO: Add a check if home manager config has fish enabled
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
        # Check out later if I'd like to SSH into the laptop from another laptop or from my phone
      ];
    };
  };

  environment.shells = with pkgs; [fish];
  programs = {fish.enable = true;};

  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    polkit_gnome
    lm_sensors
    smartmontools
    polkit_gnome
    intel-gpu-tools

    # Nix tools
    hydra-check

    # HW Monitoring tools
    lm_sensors
  ];

  security.polkit.enable = true;

  # needed by pipewire pulse
  security.rtkit.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "suspend-then-hibernate";
    extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=wlogout

      # want to be able to listen to music while laptop closed
      LidSwitchIgnoreInhibited=no
    '';
  };

  # stylix.image = ../wallpapers/veeterzy-sMQiL_2v4vs-unsplash.jpg;
  # stylix.fonts =
  #   let
  #     nf = pkgs.nerdfonts.override {
  #       fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
  #     };
  #   in
  #   {
  #     sansSerif = {
  #       package = pkgs.roboto;
  #       name = "Roboto";
  #     };

  #     serif = config.stylix.fonts.sansSerif;

  #     monospace = {
  #       package = nf;
  #       name = "JetBrainsMono Nerd Font";
  #     };

  #     emoji = {
  #       package = pkgs.noto-fonts-emoji;
  #       name = "Noto Color Emoji";
  #     };
  #   };

  services.printing = {
    enable = true;
    drivers = with pkgs; [gutenprint samsung-unified-linux-driver];
  };

  # system.autoUpgrade = {
  #   enable = true;
  #   dates = "weekly";
  #   flake = "git+https://github.com/hzmmohamed/config";
  #   flags = ["--refresh"];
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
