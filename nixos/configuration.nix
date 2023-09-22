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

    # Modules
    ./nvidia.nix
    ./vbox.nix
    ./bluetooth.nix
    ./locale.nix
    ./nvidia.nix

    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      hfahmi = import ../home-manager/home.nix;
    };
  };

  networking.hostName = "nixos";

  # Boot

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelParams = ["i915.force_probe=46a6" "i915.enable_psr=0"];
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-2d5a7033-b62c-4fad-9eac-7db206491629".device = "/dev/disk/by-uuid/2d5a7033-b62c-4fad-9eac-7db206491629";
  boot.initrd.luks.devices."luks-2d5a7033-b62c-4fad-9eac-7db206491629".keyFile = "/crypto_keyfile.bin";

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

    upower = {
      enable = true;
      criticalPowerAction = "Hibernate";
    };
    thermald.enable = true;
    cpupower-gui.enable = true;

    tlp.enable = true;
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
      permitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      passwordAuthentication = false;
    };
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
      extraGroups = ["networkmanager" "wheel" "video" "seat" "input" "docker" "adbusers" "libvirtd" "audio"];
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
        # Check out later if I'd like to SSH into the laptop from another laptop or from my phone
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    polkit_gnome
    lm_sensors
    smartmontools
    polkit_gnome

    gnome.adwaita-icon-theme
  ];

  security.polkit.enable = true;

  # needed by pipewire pulse
  security.rtkit.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
