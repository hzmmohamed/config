Nix commands

- `nix`
- `nix-env`: Used for managing environments. Use it to rollback to a generation or install a package, creating a new generation.
- `nix-channel`: Useful for adding, removing and updating channels. `nix-channel --update` is used often. It fetches the latest expressions from the channel.
- `nix-store`: Useful for inspecting the store. Nix pills demoed using it to query direct and indirect references to a package, as well as reverse references. Recall that nix stores all the derivations' dependency relations in a SQLite database at /nix/var/nix/db
- `nix-build`
