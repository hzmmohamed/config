# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


let
dbus-sway-environment = pkgs.writeTextFile {
name = "dbus-sway-environment";
destination = "/bin/dbus-sway-environment";
executable = true;

text = ''
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
systemctl--user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
systemctl--user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr

'';
};


configure-gtk = pkgs.writeTextFile {
name = "configure-gtk";
destination = "/bin/configure-gtk";
executable = true;
text = let
   schema = pkgs.gsettings-desktop-schemas;
   datadir = "${schema}/share/gsettings-schemas/${schema.name}";
  in
  ''
  export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
  gnome_schema=org.gnome.desktop.interface
  gsettings set $gnome_schema gtk-theme 'Dracula'
  '';
};

in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub = {

	enable = true;
version = 2;
device = "nodev";
efiSupport = true;
enableCryptodisk = true;	
};
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
	root = {
device = "/dev/disk/by-uuid/06d9b902-954c-43cd-9dba-c995adf22e2c";
preLVM = true;
};
};

  networking.hostName = ""; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.


fileSystems."/nix" = {
device = "/dev/disk/by-label/NIX";
fsType = "ext4";
neededForBoot = true;
options = ["noatime"];

};

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };





environment.systemPackages = with pkgs; [
alacritty
dbus-sway-environment
configure-gtk
wayland
xdg-utils
glib
dracula-theme
gnome3.adwaita-icon-theme
swaylock
swayidle
grim
slurp
wl-clipboard
bemenu
mako
wdisplays

];

services.pipewire = {
enable = true;
alsa.enable = true;
pulse.enable = true;
jack.enable = true;
};
security.polkit.enable = true;

services.dbus.enable = true;
xdg.portal = {
enable = true;
wlr.enable = true;
extraPortals = [pkgs.xdg-desktop-portal-gtk];
};

programs.sway = {
enable = true;
wrapperFeatures.gtk = true;

};


# Window Manager

  # Enable the GNOME Desktop Environment.


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.system76.enableAll = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.hfahmi = {
     isNormalUser = true;
     home = "/home/hfahmi";
     extraGroups = [ "wheel" "video" "networkmanager" ]; # Enable ‘sudo’ for the user.
     password = "0";
   };

nixpkgs.config.allowUnfree = true;
hardware.nvidia.prime = {
offload.enable = true;
intelBusId = "PCI:0:2:0";
nvidiaBusId = "PCI:1:0:0";
};
services.xserver.videoDrivers = ["nvidia"];
hardware.opengl.enable = true;
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
hardware.nvidia.modesetting.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  programs.git = {
   enable = true;
};


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

