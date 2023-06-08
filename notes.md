
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