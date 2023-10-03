{ inputs, outputs, lib, config, pkgs, ... }: {
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";
        mkdir = "mkdir -p";
      };
      shellAbbrs = {
        g = "git";
        o = "open";
      };
      plugins = with pkgs.fishPlugins; [
        {
          name = "tide";
          inherit (tide.src)
            ;
        }
        {
          name = "pisces";
          inherit (pisces.src)
            ;
        }
        {
          name = "fzf-fish";
          inherit (fzf-fish.src)
            ;
        }
        {
          name = "colored-man-pages";
          inherit (colored-man-pages.src)
            ;
        }
      ];
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    # # Bash shells automatically switch to fish unless expicitly opened from an existing fish shell
    # bash = {
    #   enable = true;
    #   # Copied from Arch Wiki https://wiki.archlinux.org/title/fish
    #   initExtra = ''
    #     if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z $BASH_EXECUTION_STRING ]]
    #     then
    #     	exec fish
    #     fi
    #   '';
    # };

    # Integrations
    mcfly = { enableFishIntegration = true; };

    zoxide = { enableFishIntegration = true; };
  };
}
