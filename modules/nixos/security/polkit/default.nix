{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.security.polkit;
in {
  options.caramelmint.security.polkit = with types; {
    enable = mkBoolOpt false "Whether to enable polkit.";
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;

    caramelmint.home.extraOptions = {
      systemd.user.services.polkit-gnome = {
        Unit = {
          Description = "PolicyKit Authentication Agent";
          After = ["graphical-session-pre.target"];
          PartOf = ["graphical-session.target"];
        };

        Service = {
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        };

        Install = {WantedBy = ["graphical-session.target"];};
      };
    };
  };
}
