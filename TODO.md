- [ ] Migrate VSCodium declaration from HM to https://github.com/nix-community/nix-vscode-extensions
- [ ] Add the Copy Relative Path and Line Numbers extension to VSCode
- [ ] Add samba shares using plusultra samba module
- [x] Add wofi-emoji + keybinding
- [ ] Add bitwarden wofi interace
- [ ] Test decreasing value of accelSpeed
- [x] Set up Lens
- [ ] Replace flameshot with shotman or grim+slurp commands or swappy https://discourse.nixos.org/t/screenshots-on-hyprland-on-nixos/29055/6?u=hfahmi
- [ ] Set up GPG + Git commit signing like before
- [x] Configure dGPU
- [ ] Chromium settings to set:
        - Use system borders
        - No bookmarks bar
        - no home button
        - Font settings
        - Theme (I don't use a theme but I could make it use the GTK or QT theme)
- [x] Make my basic shortcuts like mod+q work even in the arabic keyboard layout
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
- programs to add or master: broot, dysk, repgrep, backdown, monocle, bandwhich
- Firefox:
	- Add zotero connector add-on
	- Set "Ask download location"
	- Add add-on Highlighter + Notes
- Fix KDE Connect connection issue

- activity watchers to add and configure:
	- aw-watcher-utilization
	- aw-watcher-netstatus (This might be useful in conjunction with vnstat data to determine how much of my personal internet quota is spent on work-related things.
- Explore potential uses for wrapper-manager from viperML
## Packages to try out
- lensfun
- timelens


- Add dua to UNIX utils
- Add systemd unit cron job that permanently deletes trashed files older than 30d
- Zellij UX:
	- Make the distinction between the selected terminal and the others more pronounced!
	- Resolve conflict between Zellij Ctrl+S and that of nano. Until I use a different text editor.	
- Add packages: gh + gh-dash
- Comma + nix-index https://github.com/nix-community/nix-index-database?tab=readme-ov-file


- Fix this issue https://discourse.nixos.org/t/applications-not-finding-org-freedesktop-secrets/17667/3 which is also making AnyType crash on startup.
- Use Lutris
- Try wayshot
- NoiseTorch
- pasytray
- unixporn saves on reddit
- Persistent (across restarts) clipboard solution ( cliphist or clipmenu) (https://wiki.archlinux.org/title/clipboard) (https://mpov.timmorgan.org/super-simple-clipboard-history-for-linux/)

- Add QGIS workspace configuration to this config
- Create user profiles for CPU frequency energy and governer. Each core can be assigned a governer separately.
- Add DNS caching to network manager or by configuring systemd-resolvd with it.
- Configure Shell prompt to show the current kubectl context
- Set up tailscale and connect my laptops




- So I just did a cleaning session for my cache and trash directories and freed up 60 GBs after many months off working on this computer. The tools I frequently use that build up files are pnpm, yarn, trashy. Let's create a small command that runs these commands from anywhere. I say anywhere because for example to get pnpm in my shell I had to cd to a node project to run the command from there. Not the best approach. Works for now.
- Set up vscode with the other method that fetches extensions from the official repository
- User Vim keybindings again
- Emoji selector with wofi

- Use activity-watch home manager module