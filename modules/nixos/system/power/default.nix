{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.system.power;
in {
  options.caramelmint.system.power = with types; {
    enable = mkBoolOpt false "Whether or not to enable and configure power-saving-related services.";
  };

  config = mkIf cfg.enable {
    services = {
      logind = {
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

      # CPU and Power-related config
      upower = {
        enable = true;
        criticalPowerAction = "Hibernate";
      };
      asusd = {
        enable = true;
        enableUserService = true;
      };

      thermald = enabled;
      cpupower-gui = enabled;
      system76-scheduler = enabled;

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
    };
  };
}
