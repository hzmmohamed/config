{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.caramelmint; let
  cfg = config.caramelmint.cli-apps.fish;
in {
  options.caramelmint.cli-apps.fish = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure fish shell.";
  };

  config = mkIf cfg.enable {
    programs.fish = enabled;
    caramelmint.home.extraOptions = {
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
            lg = "lazygit";
            kc = "kubectl";
          };
          plugins = with pkgs.fishPlugins; [
            {
              name = "tide";
              src = tide.src;
            }
            {
              name = "pisces";
              src = pisces.src;
            }
            {
              name = "fzf-fish";
              src = fzf-fish.src;
            }
            {
              name = "colored-man-pages";
              src = colored-man-pages.src;
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
      };
    };
  };
}
