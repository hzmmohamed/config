{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.tools.yazi;
in {
  options.caramelmint.tools.yazi = with types; {
    enable = mkBoolOpt false "Whether or not to enable yazi.";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        log = { enabled = false; };
        manager = {
          show_hidden = false;
          show_symlink = true;
          linemode = "mtime";
          sort_by = "modified";
          sort_dir_first = true;
          sort_reverse = true;
        };
      };
    };

    # Extra packages for preview functionality
    # https://yazi-rs.github.io/docs/installation/
    home.packages = with pkgs; [ imagemagick poppler ];
  };
}
