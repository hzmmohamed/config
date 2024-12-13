{ ... }: {
  imports = [ ./disk-config.nix ];
  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMhxcLHsjikNd2JG4vRp55lEaJpUZNYS3TdjQ9aIii9T hzmmohamed@gmail.com"
  ];
}
