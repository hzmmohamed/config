{
  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["hfahmi"];
  # setting vbox guest causes a boot problem https://github.com/NixOS/nixpkgs/pull/60938  and https://github.com/NixOS/nixpkgs/issues/58127
  virtualisation.virtualbox.guest.enable = false;
  virtualisation.virtualbox.guest.x11 = true;
}
