{ inputs, outputs, lib, config, pkgs, ... }: {
  # Nvidia
  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # hardware.nvidia.prime = {
  #   offload = {
  #     enable = true;
  #     enableOffloadCmd = true;
  #   };

  #   intelBusId = "PCI:00:02:0";
  #   nvidiaBusId = "PCI:01:00:0";
  # };

  hardware.enableAllFirmware = true;
  # NVIDIA drivers are unfree.
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "nvidia-x11"
  #   ];

  # Tell Xorg to use the nvidia driver
  # services.xserver.videoDrivers = ["nvidia"];

  # hardware.nvidia = {
  #   # Modesetting is needed for most wayland compositors
  #   modesetting.enable = true;

  #   # Use the open source version of the kernel module
  #   # Only available on driver 515.43.04+
  #   # open = true;

  #   # Fix screen tearing on external display. HDMI port is directly connected to dGPU
  #   forceFullCompositionPipeline = true;

  #   # Enable the nvidia settings menu
  #   nvidiaSettings = true;

  #   # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #   package = config.boot.kernelPackages.nvidiaPackages.beta;
  # };
}
