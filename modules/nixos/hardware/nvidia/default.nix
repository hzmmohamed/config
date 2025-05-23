{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.hardware.nvidia;
in {
  options.caramelmint.hardware.nvidia = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable and configure NVIDIA dGPU support.";
  };

  config = mkIf cfg.enable {
    # specialisation = {
    #   dGPU.configuration = {
    # system.nixos.tags = [ "dGPU" ];
    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];
    services.ollama.acceleration = "cuda";

    hardware.nvidia = {
      # Modesetting is required.
      # modesetting = enabled;

      # dynamicBoost = enabled;

      prime = {
        # Make sure to use the correct Bus ID values for your system!
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        # Enable PRIME Offload
        offload.enable = lib.mkForce true;
        offload.enableOffloadCmd = lib.mkForce true;
        sync.enable = lib.mkForce false;
      };

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = false;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    # };
    # };
  };
}
