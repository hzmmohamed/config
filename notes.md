
Remaining steps:
- Configure sway (See how far I can get with home-manager)
- Copy over the dotfiles
    - SSH
    - AWS
    - git config
- Refactor to Snowfall lib
- Install docker, kind, and other development tools. See what I have installed on the other machine.

What do I need from the other laptop to be able to work on this one?
- All the home dir files that haven't been pushed to remote version control
- Development tools


What are the pros and cons of using Home manager + Nix vs NixOS?
- I love that PopOS just works out of the box. I think I can get very far with Nix and home manager. It would be a good thing to list the functionalities that are configured outside Nix on the system level.
- NixOS is very constraining. I can't even run a normal binary within the system itself. I will need something like distrobox. For example, I now don't have decent sampler on nixpkgs. How do I run it without containerisation? I will need to package it.
- What else




Power management and thermal management:
- Install upower (Set it to hibernate on battery level reaching 2%)
- Install TLP (automatic cpu governor switching on changing power source and other events)
- cpupower (tool for reporting and setting cpu governor and frequency)
- cpupower-gui (GUI version of cpupower)
- powertop (not used)
- thermald (It is a service that monitors CPU thermals and takes actions to prevent overheating when the CPU is heavily loaded.) (https://www.reddit.com/r/archlinux/comments/3okrhl/thermald_anyone/) (https://www.reddit.com/r/GamingLaptops/comments/uqotlp/asus_tuf_f15_2022_temperature_issues/)

- https://ivanvojtko.blogspot.com/2016/04/how-to-get-longer-battery-life-on-linux.html
- Kernel laptop mode (is it any useful?) (https://docs.kernel.org/admin-guide/laptops/laptop-mode.html)
- Battery health
    https://www.makeuseof.com/how-to-check-your-laptops-battery-health-in-linux/
- Fan monitoring and management
    I need to test the fan's response to CPU temperatures. Do I need to turn on fancontrol service?
        - fancontrol service from lmsensors
        - nbfc
        - https://wiki.archlinux.org/title/fan_speed_control#Fancontrol_(lm-sensors)
- asusd
    I'm not sure asusd service is suited for my laptop. Let's see.

- Add a waybar module to show the current cpu governor and cpu frequency
- turbostat?
- learn to understand the powertop stats and `cpupower monitor` stats (https://linux.die.net/man/1/cpupower-monitor)
- Read and summarize the TLP documentation
- Document tlp vs.autocpu-freq vs. power-profiles-daemon
- configure logind lidswitch actions correctly
https://wiki.archlinux.org/title/Laptop#Power_management
- Stress testing the system with stress-ng (https://www.youtube.com/watch?v=gbVNQHSpKeI)

- waybar cpu governor module (https://github.com/Pipshag/dotfiles_nord/blob/master/.config/waybar/custom_modules/cpugovernor.sh)
- Read this arch wiki page(https://wiki.archlinux.org/title/CPU_frequency_scaling)
- i7z

https://linuxhint.com/monitor_optimize_power_usage/
- upower --monitor-detail
- acpi 
- powerstat





To do:
- Fix docker rootless mode or replace with podman
- Fix flameshot portals problem (https://github.com/flameshot-org/flameshot/issues/2872)
- fix waybar temperature widget
- setup kanshi + install wdisplays
- install catpcuccin theme 
- enable upower and configure its actions (the goal is to be able to understand what consumes power)
- install code formatting extensions for vscode


Other features to add:
- Add widget to show both the current power configuration (balance, balance_power, etc.) and the cpu governor and the cpu frequency
- Add the ability to disable lidswitch close action in an ad hoc way, for situations where I'd like to the keep the computer running after closing the lid 
- Sleep then hibernate after duration + Hibernate right away if battery under threshold ---> solution: https://gist.github.com/mattdenner/befcf099f5cfcc06ea04dcdd4969a221

- Wrap chromium and electron apps with `wrapProgram` and add flags `--enable-features=UseOzonePlatform`
- Nvidia support
- second display support + Kanshi
- virtualbox + windows vm + ubuntu vm
- [DONE] clipboard management
- flameshot service is active and running but not showing in the system tray. Probably the system tray is not available when flameshot starts

- codium crashes when run without --disable-gpu.

- Maybe use virtualisation.kvmgt.enable

- bluetooth headset audio quality is very poor when configured as a both source and sink
    There is currently no perfect solution. The best to do is to switch to the bidirectional (and worse) profile during calls and back to the unidirectional A2DP profile when only listening to audio.
- Configure notification daemon styles and font
<!-- - logkeys service -->
- switcheroo service
- on resuming from hibernate or on restarting sway --> restart waybar service + restart services that live in the tray like flameshot, nm-applet, udiskie, and blueman. Is there a way to define this relationship and have systemd restart them by just restarting waybar?
- Codium and other electron apps issue with GPU on wayland: https://github.com/NixOS/nixpkgs/issues/158947
- Setting up secrets like Kubernetes Credentials using sops or these othehr tools
- Setup mime associations
- Setup battery charging limits in TLP config
- Show TLP CPU and platform profile in the status bar +  Make a wofi selector for these profiles.
- Add psi-notify and configure its thresholds
- Show swap in the memory widget in waybar https://www.reddit.com/r/swaywm/comments/smfor2/waybar_swap_widget/
