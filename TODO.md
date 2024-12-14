- [ ] Migrate VSCodium declaration from HM to https://github.com/nix-community/nix-vscode-extensions
- [ ] Add the Copy Relative Path and Line Numbers extension to VSCode
- [ ] Add samba shares using plusultra samba module
- [ ] Add bitwarden wofi interace
- [ ] Test decreasing value of accelSpeed
- [ ] Set up GPG + Git commit signing like before
- [ ] Chromium settings to set:
        - Use system borders
        - No bookmarks bar
        - no home button
        - Font settings
        - Theme (I don't use a theme but I could make it use the GTK or QT theme)
- [ ] Tweak waybar ( Add Memory module, etc.)
- [ ] Add swaysr for feedback on changing volume or brightness
- [ ] Add GillSans
- [ ] Fix DBeaver GTK issues
- [ ] Ricing
- [ ] Index all files on my laptop and be able to fuzzy search through them. Plus what if I can search images with an image like Google Images.
- [ ] Add fire plugin, calf Plugins and other plugins from VenusTheory's video
- [ ] Add cool cursor theme (https://www.gnome-look.org/p/2121191, https://nixos.wiki/wiki/Cursor_Themes)
- [ ] kde connect
- [ ] Configure firefox privacy settings defaults
- [ ] Log system resource utilization per process with atop
- [ ] Add preview to fzf widget commands + Change completion trigger https://www.youtube.com/watch?v=MvLQor1Ck3M
- Codium extensions: 
fwcd.kotlin --> Install and configure paths for JDK and stuff or disable those features altogether and use the LSP only

- Add treefmt to dev env
- Build a good workflow with Thunderbird as my flow

- programs to add or master: broot, dysk, repgrep, backdown, monocle, bandwhich
- Fix KDE Connect connection issue

- activity watchers to add and configure:
	- aw-watcher-utilization
	- aw-watcher-netstatus (This might be useful in conjunction with vnstat data to determine how much of my personal internet quota is spent on work-related things.

- Add systemd unit cron job that permanently deletes trashed files older than 30d
- Zellij UX:
	- Make the distinction between the selected terminal and the others more pronounced!
	- Resolve conflict between Zellij Ctrl+S and that of nano. Until I use a different text editor.	
- Add packages: gh + gh-dash


- Fix this issue https://discourse.nixos.org/t/applications-not-finding-org-freedesktop-secrets/17667/3 which is also making AnyType crash on startup.
- Use Lutris
- Try wayshot
- NoiseTorch
- pasytray
- Persistent (across restarts) clipboard solution ( cliphist or clipmenu) (https://wiki.archlinux.org/title/clipboard) (https://mpov.timmorgan.org/super-simple-clipboard-history-for-linux/)

- Add QGIS workspace configuration to this config

- Create user profiles for CPU frequency energy and governer. Each core can be assigned a governer separately.

- Add DNS caching to network manager or by configuring systemd-resolvd with it.


- Configure Shell prompt to show the current kubectl context



- So I just did a cleaning session for my cache and trash directories and freed up 60 GBs after many months off working on this computer. The tools I frequently use that build up files are pnpm, yarn, trashy. Let's create a small command that runs these commands from anywhere. I say anywhere because for example to get pnpm in my shell I had to cd to a node project to run the command from there. Not the best approach. Works for now.
- Set up vscode with the other method that fetches extensions from the official repository
 






- Create one interface for both the asusctl profile and the cpu-power profile. Probably through a wofi selector and with a system-tray indicator
- Configure birdtray or look into thunderbird's system tray feature in the latest version. Probably will need to get it from nix-unstable/nix-latest.



- [ ] Make sure that Obsidian send files to system trash. Currently seems like it doesn't do that. Find out where it sends deleted files.

- Firefox:
	- Add zotero connector add-on to config
	- [x] Set "Ask download location"
	- Add add-on Highlighter + Notes 

- Add wifi-qr to config
- Add newsflash and subscribe to RSS feeds that I care about.
- Look for the userland daemon for shortcuts and migrate shortcuts from sway to it!
- Add a wallpaper and make the top bar more pretty
- [x] Comma + nix-index https://github.com/nix-community/nix-index-database?tab=readme-ov-file

- [x] Make my basic shortcuts like mod+q work even in the arabic keyboard layout
- [x] Add dua to UNIX utils

- [x] Emoji selector with wofi

- [x] Add `cl` as alias for clear
- [x] Enable automatic-timezoned or localtimed
- [x] Make the laptop log out of my account when it goes to sleep


- [x] Add auto-cpu freq
- [x] Add udiskie again


- Add clamav
- Quick workflow to get the transcription of a video into an Obsidian note, and start editing.
- Run an LLM locally and fine tune it on a TfC report.


create alias for docker delete all images

I want to return the systemd generations menu on 

Use the ipermanence module

Use SOPS-nix:
	- Password
	- wifi passwords
	- share ssh key?


Factor out the arabic compatibility settings (if any) like RTL support in terminal or such into a separate module!

Factor out firewall/opensnitch into its own module
Figure out cliphist

Yazi is acting weird in alacritty

Switch to foot?

Fix tlp config
fix gnome-keyring startup isssues


Parallel Disk Usage is blazingly fast in returning a result, but it's off by a huuuuge margin.