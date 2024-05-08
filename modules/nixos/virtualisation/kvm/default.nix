{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.virtualisation.kvm;
  user = config.caramelmint.user;
in {
  options.caramelmint.virtualisation.kvm = with types; {
    enable = mkBoolOpt false "Whether or not to enable KVM virtualisation.";
    vfioIds =
      mkOpt (listOf str) []
      "The hardware IDs to pass through to a virtual machine.";
    platform =
      mkOpt (enum ["amd" "intel"]) "intel"
      "Which CPU platform the machine is using.";
    # Use `machinectl` and then `machinectl status <name>` to
    # get the unit "*.scope" of the virtual machine.
    machineUnits =
      mkOpt (listOf str) []
      "The systemd *.scope units to wait for before starting Scream.";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelModules = [
        "kvm-${cfg.platform}"
        "vfio_virqfd"
        "vfio_pci"
        "vfio_iommu_type1"
        "vfio"
      ];
      kernelParams = [
        "${cfg.platform}_iommu=on"
        "${cfg.platform}_iommu=pt"
        "kvm.ignore_msrs=1"
      ];
      extraModprobeConfig =
        optionalString (length cfg.vfioIds > 0)
        "options vfio-pci ids=${concatStringsSep "," cfg.vfioIds}";
    };

    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${user.name} qemu-libvirtd -"
      "f /dev/shm/scream 0660 ${user.name} qemu-libvirtd -"
    ];

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      virtiofsd
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      gnome.adwaita-icon-theme

      # Needed for Windows 11
      swtpm
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        extraConfig = ''
          user="${user.name}"
        '';

        onBoot = "ignore";
        onShutdown = "shutdown";

        qemu = {
          swtpm.enable = true;

          package = pkgs.qemu_full;
          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };
          verbatimConfig = ''
            namespaces = []
            user = "+${builtins.toString config.users.users.${user.name}.uid}"
          '';
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;

    caramelmint = {
      user = {extraGroups = ["qemu-libvirtd" "libvirtd" "disk"];};

      home = {
        extraOptions = {
          systemd.user.services.scream = {
            Unit.Description = "Scream";
            Unit.After =
              [
                "libvirtd.service"
                "pipewire-pulse.service"
                "pipewire.service"
                "sound.target"
              ]
              ++ cfg.machineUnits;
            Service.ExecStart = "${pkgs.scream}/bin/scream -n scream -o pulse -m /dev/shm/scream";
            Service.Restart = "always";
            Service.StartLimitIntervalSec = "5";
            Service.StartLimitBurst = "1";
            Install.RequiredBy = cfg.machineUnits;
          };
        };
      };
    };
  };
}
