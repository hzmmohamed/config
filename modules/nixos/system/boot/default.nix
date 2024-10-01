{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.system.boot;
in {
  options.caramelmint.system.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting.";
  };

  config = mkIf cfg.enable {
    boot = {
      # Bootloader
      loader.systemd-boot.enable = true;
      loader.systemd-boot.configurationLimit = 5;
      loader.efi.canTouchEfiVariables = true;
      loader.efi.efiSysMountPoint = "/boot/efi";

      # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
      loader.systemd-boot.editor = false;

      # Setup keyfile
      initrd.secrets = { "/crypto_keyfile.bin" = null; };
      # Enable swap on luks
      initrd.luks.devices."luks-2d5a7033-b62c-4fad-9eac-7db206491629".device =
        "/dev/disk/by-uuid/2d5a7033-b62c-4fad-9eac-7db206491629";
      initrd.luks.devices."luks-2d5a7033-b62c-4fad-9eac-7db206491629".keyFile =
        "/crypto_keyfile.bin";

      # Kernel
      kernelParams = [ "i915.force_probe=46a6" ];
      blacklistedKernelModules = [
        # "nouveau"
        # "intel_lpss_pci"
      ];
    };
  };
}
