
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

- Add a waybar module to show the current cpu governor and cpu frequency
- turbostat?
- learn to understand the powertop stats and `cpupower monitor` stats (https://linux.die.net/man/1/cpupower-monitor)
https://wiki.archlinux.org/title/Laptop#Power_management
- Stress testing the system with stress-ng (https://www.youtube.com/watch?v=gbVNQHSpKeI)

- waybar cpu governor module (https://github.com/Pipshag/dotfiles_nord/blob/master/.config/waybar/custom_modules/cpugovernor.sh)
- Read this arch wiki page(https://wiki.archlinux.org/title/CPU_frequency_scaling)
- i7z

https://linuxhint.com/monitor_optimize_power_usage/
- upower --monitor-detail
- acpi 
- powerstat


What are C-state and P-state and their formula of PCU utilization?
Could high-performance CPUs like H CPUs not be suited to running at a low clock speed? Would undervolting work for them or disabling some of the cores?
Apparently, 12th-gen H and U processors cannot  be undervolted. https://www.reddit.com/r/intel/comments/wormah/safe_undervolt_for_12th_gen_inteli5_cpu/
https://twitter.com/toniievych/status/1619453625050492928?lang=en





To do:
- Fix docker rootless mode or replace with podman
- [done] Fix flameshot portals problem (https://github.com/flameshot-org/flameshot/issues/2872)
- fix waybar temperature widget
- setup kanshi + install wdisplays
- install catpcuccin theme 
- enable upower and configure its actions (the goal is to be able to understand what consumes power)
- install code formatting extensions for vscode


Other features to add:
- Add widget to show both the current power configuration (balance, balance_power, etc.) and the cpu governor and the cpu frequency
- Add the ability to disable lidswitch close action in an ad hoc way, for situations where I'd like to the keep the computer running after closing the lid 
- Hibernate right away if battery under threshold ---> solution: https://gist.github.com/mattdenner/befcf099f5cfcc06ea04dcdd4969a221

- Nvidia support
- second display support + Kanshi
- virtualbox + windows vm + ubuntu vm

- clipboard management


- Configure notification daemon styles and font
<!-- - logkeys service -->
- on resuming from hibernate or on restarting sway --> restart waybar service + restart services that live in the tray like flameshot, nm-applet, udiskie, and blueman. Is there a way to define this relationship and have systemd restart them by just restarting waybar?
- Codium and other electron apps issue with GPU on wayland: https://github.com/NixOS/nixpkgs/issues/158947

- Setup battery charging limits in TLP config
- Show TLP CPU and platform profile in the status bar +  Make a wofi selector for these profiles.
- Add psi-notify and configure its thresholds
- add asus hwmon kernel package

- enable default network in virt-manager by default (using systemd?)

- Make floating windows transparent and experiment with that for a while

- Make my basic shortcuts like mod+q work even in the arabic keyboard layout


- Setting up secrets like Kubernetes Credentials using sops or these othehr tools
- Setup mime associations

- Try putting shortcuts to workspaces on the home row with held keys or with a leader key
- ANother variation on the previous idea: Replace mod with space bar and see if conflicts happen during typing
- Have charing limit at 70%, and send notifications to myself every 5 minutes when the battery gets below 40%
- Configure screen dim after 5 minutes of inactivity + Configure sleep after 15 minutes of inactivity, then hibernate.



-- Amazing accidental discovery:
When the dGPU is completely turned off, battery life is greatly extended. Since I rarely use it, I should definitely use the boot variations, one without dPGU and the other with PRIME Sync or offload. There's even more: 


Packages to add:
- slides
-  zmore, zless, zcat, zgrep, zdiff
- zbar



I tried it and it worked. Let's packageit for nixpkgs.
- wifi-qr (package it for nixpkgs or NUR) (It's easy, it's just a simple shell script) (Check this post https://www.ertt.ca/nix/shell-scripts/)



- Document the windows plugins I use:
	- Valhalla Supermassive, Swanky Amp
https://midination.com/vst/free-vst-plugins/best-free-vst-plugins/
https://bedroomproducersblog.com/2019/10/31/free-synthesizer-vst-plugins/
https://midination.com/vst/free-vst-plugins/free-drum-vst/

Add GUI for brightness and volume control, it's easier to access when the keyboard key labels are not visible.
Add keyboard shortcuts for go back and forward to my VSCodium config in home-manager
Add Gill Sans font
- Add floating window rule location for QGIS's measure window. I want it to go by default in a corner of the screen not in the center.
- Add Cadence for Pro-Audio management
- Add Carla for hosting plugins outside the DAW
- Add Theme Switcher to VSCodium to switch theme by time of day https://burkeholland.dev/posts/vscode/auto-switch-themes/#:~:text=Open%20the%20settings.,time%20(24%20hour%20format).



Chromium settings to set:
- Use system borders
- No bookmarks bar
- no home button
- Font settings
- Theme (I don't use a theme but I could make it use the GTK or QT theme)


Consider librewolf


Fonts:
https://www.theleagueofmoveabletype.com/junction
https://bootcamp.uxdesign.cc/17-free-to-download-sans-serif-fonts-that-you-might-never-heard-of-35b8b2787962

Dynamic themes by time of day for the whole system: https://www.reddit.com/r/NixOS/comments/13w9o1i/dynamically_changing_themes_in_nixos/jn32iyl/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
https://discourse.nixos.org/t/how-to-enable-global-dark-mode-using-home-manager-in-nixos/28348

- change networking.networkmanager.insertNameservers to cloudflare and google
- VSCodium add the back and forward shortcuts in the settings config
- Add Sway Notification Center
- Add RSS Reader and configure my selected new sources


Resources on dev shells:
- https://determinate.systems/posts/nix-direnv
- https://github.com/the-nix-way/dev-templates/blob/main/python/flake.nix
- https://devenv.sh/guides/using-with-flakes/#automatic-shell-switching-with-direnv
- https://shyim.me/blog/devenv-compose-developer-environment-for-php-with-nix/
- Riff
- Devbox





https://bootcamp.uxdesign.cc/17-free-to-download-sans-serif-fonts-that-you-might-never-heard-of-35b8b2787962




Little convenience things that would be amazing to have across apps:
- Being able to not just move the cursor to the start of next word, but to the next upper case later in the same word, and similarly for separators like hyphen and underscore.