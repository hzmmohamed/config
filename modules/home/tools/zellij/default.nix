{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.tools.zellij;
in {
  options.caramelmint.tools.zellij = with types; {
    enable = mkBoolOpt false "Whether or not to enable Zellij.";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        # theme = "default";
        # themes = {
        #   default = with config.colorScheme.palette; {
        #     bg = "#${base00}";
        #     fg = "#${base05}";
        #     black = "#${base01}";
        #     white = "#${base06}";
        #     red = "#${base08}";
        #     yellow = "#${base09}";
        #     green = "#${base0B}";
        #     cyan = "#${base0C}";
        #     blue = "#${base0D}";
        #     magenta = "#${base0E}";
        #     orange = "#${base0F}";
        #   };
        # };
      };
    };
  };
}
