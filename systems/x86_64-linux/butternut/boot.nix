{ options, config, pkgs, lib, ... }: {
  boot = {
    # Kernel
    kernelParams = [ "i915.force_probe=46a6" ];
    blacklistedKernelModules = [
      # "nouveau"
      # "intel_lpss_pci"
    ];
  };

}
