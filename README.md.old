# Computing Environment Documentation

## WM
sway
config


# General Audio
## Pipewire
### Packages
- pipewire-jack
- pipewire-pulse
- pipewire

### Config
- Pipewire profiles
- Default Latency settings for certain apps


## Music/Recording
### DAW and Plugins
- ardour
- non-daw (group)
- supercollider
  - sc3-plugins
- Plugins
  - Arch repository
    - guitarix
    - gxplugins.lv2
    - BSEQuencer
    - artyfx
    - avldrums.lv2
    - dragonfly-reverb-lv2
    - calf
    - helm-synth
    - infamousplugins
    - sfizz
    - odin2-synthesizer
    - surge
    - surge-xt
    - ob-xd
    - sorcer
    - wolf-shaper
    - sherlock.lv2
    - element (I recall that it had a dealbreaker disadvantage.)
    - yoshimi
    - x42-plugins
    - x42-avldrums
    - amsynth
  - AUR
    - aether.lv2
    - ctr-?
    - mod-?
    - chowbyod-bin
    - chowcentaur-bin
    - chowmatrix-bin
    - chowkick-bin
    - chowtapemodel-bin
    - chowphaser-bin

    - pianoteq-stage-trial-bin
    - pianoteq-standard-trial-bin 
    - decent-sampler

    - uhe-hive-vst
    - uhe-podolski-vst
    - uhe-triplecheese-vst
    - tal-plugins
    - supercollider-vstplugin
    - paulxstretch
    - tunefish4
    - binaural-vst-git
    - octasine
    - spectacle-analyzer.lv2-git
    - zplugins.lv2-git
    - xdarkterror.lv2-git
    - xtinyterror.lv2-git
  - Other:
    - 


  - Windows Plugins
    - Kontakt 

- patchmatrix
- luppp
- carla

- solfege
- musescore

- jack_delay
- jack_capture
- realtime-privileges
- rtirq
- tuna?
- master_me
- patchmatrix
- yabridge


## System maintenance/debugging
- Install group linux-tools


## Other
- lib32-gcc-libs # It was needed by something along the way. Not sure I documented it. I had to enable multilib to pacman.conf first.



## Video
### Packages
- kdenlive


## Printer


## Finding Files





## Basic Structure:
- Why I choose Arch Linux?
- This org file is intended to be tangled into a single script that runs on clean arch install. The script installs packages, stows config into respective directories, and applies any config I need in my terminal or in my system generally.


- enable multilib in pacman.conf
- yay -S downgrade

## File Indexing and Quick finding setup
Index all the repos so I can do full text searches on all the repos I have cloned locally. This aids in situations where I need to quickly find a piece of code that I've written before.


## Packages
- expac
- sfizz
- exfat-utils
- x11-ssh-askpass (necessary for some cases where vs-code prompts for ssh keyphrase)
- bottom (https://clementtsang.github.io/bottom/nightly/usage/widgets/process/)
- Mako/Dunst
- swaybg
- grimshot ( a very hand script for grim) https://aur.archlinux.org/packages/grimshot   https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway#screenshot
- qgis
- p7zip
- waybar
- openssh
- stow
- tldr
- rofi
- wofi
- chromium
- playerctl https://github.com/altdesktop/playerctl
- light  You only need to add user to video group


- kde-connect
- docker 
    sudo pacman -S docker # installs docker engine
    sudo pacman -S docker-compose
    sudo usermod -aG docker hazem
    sudo systemctl enable docker.service
    Restart
    Verify with docker info / docker run hello-world
    Change the images location (https://wiki.archlinux.org/title/docker#Images_location)
- pip
    pacman -S python-pip
- fish
- nvm.fish https://github.com/jorgebucaran/nvm.fish
- yarn
    corepack enable (node version >=16.10) https://yarnpkg.com/getting-started/install
- gstreamer
    along with gst-libav, gst-plugins-base,  gst-plugins-good, gst-plugin-pipewire
    https://wiki.archlinux.org/title/GStreamer#Installation
- nvidia gfx packages from systemconfig notes
- flameshot
- dbeaver
- photoqt
- mpv
- noto-fonts (for supporting all script types out of the box)
- noto-fonts-emoji
- figma-linux  

- tilt
  - Add `tilt completion fish > ~/.config/fish/completions/tilt.fish` to the setup script


git diff -p -R --no-ext-diff --no-color \


                                                              | grep -E "^(diff|(old|new) mode)" --color=never | git apply



- It's embarassing that wifi is so tedious on linux. What makes it work so smoothly on Pop and ubuntu, even though they use the same packages like Network Manager? I've come across the "Secrets were required, but not provided" error. I tried all the methods (https://wiki.archlinux.org/title/NetworkManager#Secrets_were_required,_but_not_provided) but nothing solves it but a reboot. Go figure out the problem. Potentially the use of iwd contributes to the issue. Read more on iwd in the docs (https://iwd.wiki.kernel.org/)

- Import GPG key

- Download FiraCode from nerdfonts and unzip to ~/.local/share/fonts
"The font files need to have sufficient read permissions for all users, i.e. at least chmod 444 for files, and 555 for directories."
https://wiki.archlinux.org/title/fonts#Manual_installation

fc-cache

- VS Code config


- Safely Mount flash drives automatically on plugging in? How to?

- Configure a shortcut to pull up a floating terminal windows automatically. Something like Shift+Mod+Return

- Configure the WM to sleep after 10 mins of inactivity. But offer the ability to turn it off in case I want to intentionally leave a long-running process without using the computer.

- nftables caused a problem with the default bridge network in docker. Don't use it just yet. Learn it first, then have a reason to use firewall in the first place. 

- How to have WM shortcuts work in any keyboard layout. Perhaps they should be set on the keyboard key Identifier? How?
- Need to see tips and tricks on configuring multi-monitor setups in sway
- 
https://wiki.archlinux.org/title/Desktop_notifications#Notification_servers

- How to configure showing RTL text correctly in the terminal?
- How to make the headphone mic work?
- Look at the shell script that runs on sleep/wakeup https://www.cyberciti.biz/faq/linux-command-to-suspend-hibernate-laptop-netbook-pc/

- Packages:
    - expac
    - sfizz
    - exfat-utils
    - x11-ssh-askpass (necessary for some cases where vs-code prompts for ssh keyphrase)
    - bottom (https://clementtsang.github.io/bottom/nightly/usage/widgets/process/)
    - Mako/Dunst
    - swaybg
    - grimshot ( a very hand script for grim) https://aur.archlinux.org/packages/grimshot   https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway#screenshot
    - qgis
    - p7zip
    - waybar
    - openssh
    - stow
    - tldr
    - rofi
    - wofi
    - chromium
    - playerctl https://github.com/altdesktop/playerctl
    - light  You only need to add user to video group
    - kde-connect
    - docker 
        sudo pacman -S docker # installs docker engine
        sudo pacman -S docker-compose
        sudo usermod -aG docker hazem
        sudo systemctl enable docker.service
        Restart
        Verify with docker info / docker run hello-world
        Change the images location (https://wiki.archlinux.org/title/docker#Images_location)
    - pip
        pacman -S python-pip
    - fish
    - nvm.fish https://github.com/jorgebucaran/nvm.fish
    - yarn
        corepack enable (node version >=16.10) https://yarnpkg.com/getting-started/install
    - gstreamer
        along with gst-libav, gst-plugins-base,  gst-plugins-good, gst-plugin-pipewire
        https://wiki.archlinux.org/title/GStreamer#Installation
    - nvidia gfx packages from systemconfig notes
    - flameshot
    - dbeaver
    - photoqt
    - mpv
    - noto-fonts (for supporting all script types out of the box)
    - noto-fonts-emoji
    - figma-linux (aur) https://aur.archlinux.org/packages/figma-linux (remember to delete the problematic file as insntructed in the thread on aur page)
    - visual-studio-code-bin (AUR) this is the official build from microsoft. The one in the comunity repo is a custom build from source. When I installed it, it had the settings sync removed, etc. The official build probably has features other than the open source version on github.

- Getting arabic fonts to work correctly: https://wiki.archlinux.org/title/Font_configuration/Examples#Arabic
- a smooth network manager setup
	I tried to use iwd as a backend. The slow/endless connect after waking from suspend no longer happens. Still, network manager doesn't automatically connect to nearby known accesspoints.
	https://wiki.archlinux.org/title/NetworkManager#Using_iwd_as_the_Wi-Fi_backend
	
- setting up ssh-agent
    https://github.com/White-Oak/arch-setup-for-dummies/blob/master/setting-up-ssh-agent.md
    The idea here is to run ssh-agent automatically on login
    I have renamed my keys back to id_rsa dn id_rsa.pub because these are default names that are autmatically supported by ssh-add for example.



- To enable full screen webrtc sharing on wayland at chrome://flags/#enable-webrtc-pipewire-capturer

Convenience issue with this minimal setup:
- Zipping and extracting archives
- Having to mount external storage manually
- Image and PDF reading


Essential things to set up before tomorrow
- Working python env (done)
- Working node (done)
- Run RL FE and BE in dev ()
- Working teams with appropriate mic level


- Install figma app and notion app


nnn seems quite fast to use, actually. I would like to index my home directory and do fuzz searches quickly. Also I would like to know the size of directories from nnn correctly, not the 4K value. This is much better than using du -sh.

nnn doesn't have cp or mv progress by default.

Install plugins for nnn
https://github.com/jarun/nnn/tree/master/plugins#installation
export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'
