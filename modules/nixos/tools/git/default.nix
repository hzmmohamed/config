{ options, config, pkgs, lib, ... }:
with lib;
with lib.caramelmint;
let
  cfg = config.caramelmint.tools.git;
  gpg = config.caramelmint.security.gpg;
  user = config.caramelmint.user;
in {
  options.caramelmint.tools.git = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git.";
    userName = mkOpt types.str user.fullName "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
    signingKey =
      mkOpt types.str "9762169A1B35EA68" "The key ID to sign commits with.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      git-dive
      lazygit
      gitui
      gibo
      git-crypt
    ];

    # TODO: Move these systempacakges to home packages?

    caramelmint.home.extraOptions = {
      programs.git = {
        enable = true;
        inherit (cfg) userName userEmail;
        lfs = enabled;
        # signing = {
        #   key = cfg.signingKey;
        #   signByDefault = mkIf gpg.enable true;
        # };
        delta = {
          enable = true;
          options = {
            navigate = true;
            line-numbers = true;
            syntax-theme = "GitHub";
          };
        };
        extraConfig = {
          init = { defaultBranch = "main"; };
          pull = { rebase = true; };
          push = { autoSetupRemote = true; };
          core = { whitespace = "trailing-space,space-before-tab"; };
          safe = {
            # directory = "${config.users.users.${user.name}.home}/personal/config";
            directory = "*";
          };
        };
      };

      # Add lazygit
      programs.lazygit = enabled;

      home.packages = with pkgs; [ gibo ];
    };
  };
}
